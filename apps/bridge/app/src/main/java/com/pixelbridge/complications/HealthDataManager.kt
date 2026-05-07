package com.pixelbridge.complications

import android.content.ComponentName
import android.content.Context
import android.util.Log
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.services.client.HealthServices
import androidx.health.services.client.PassiveListenerService
import androidx.health.services.client.data.DataPointContainer
import androidx.health.services.client.data.DataType
import androidx.health.services.client.data.PassiveListenerConfig
import androidx.health.services.client.data.DataPoint
import androidx.health.services.client.data.CumulativeDataPoint
import androidx.health.services.client.data.SampleDataPoint
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceUpdateRequester
import kotlinx.coroutines.guava.await
import java.time.Duration
import java.time.Instant

class HealthDataManager(private val context: Context) {
    companion object {
        private const val PREFS_NAME = "health_data"
        private const val UNKNOWN_VALUE = "--"
    }

    private val complicationTypeAliases: Map<String, Set<String>> = mapOf(
        DataType.HEART_RATE_BPM.name to setOf(DataType.HEART_RATE_BPM.name),
        DataType.STEPS.name to setOf(DataType.STEPS.name, "STEPS_DAILY"),
        DataType.CALORIES_TOTAL.name to setOf(DataType.CALORIES_TOTAL.name, "CALORIES_DAILY"),
        DataType.DISTANCE.name to setOf(DataType.DISTANCE.name, "DISTANCE_DAILY"),
        DataType.FLOORS.name to setOf(DataType.FLOORS.name, "FLOORS_DAILY"),
        "SPO2" to setOf("SPO2"),
        "RESPIRATORY_RATE" to setOf("RESPIRATORY_RATE")
    )

    private val healthServicesClient = HealthServices.getClient(context)
    private val passiveMonitoringClient = healthServicesClient.passiveMonitoringClient
    private val healthConnectClient by lazy { HealthConnectClient.getOrCreate(context) }

    suspend fun getSupportedDataTypes(): Set<DataType<*, *>> {
        val capabilities = healthServicesClient.passiveMonitoringClient.getCapabilitiesAsync().await()
        return capabilities.supportedDataTypesPassiveMonitoring
    }

    suspend fun registerPassiveListener() {
        val supported = getSupportedDataTypes()
        // Use stable 1.0.0 DataType names
        val requestedNames = complicationTypeAliases.values.flatten().toSet()
        
        val dataTypes = supported.filter { it.name in requestedNames }.toSet()

        if (dataTypes.isEmpty()) {
            Log.w("HealthDataManager", "No supported data types for passive monitoring")
            return
        }

        val config = PassiveListenerConfig.builder()
            .setDataTypes(dataTypes)
            .build()
        
        try {
            passiveMonitoringClient.setPassiveListenerServiceAsync(
                HealthPassiveListenerService::class.java,
                config
            ).await()
            Log.d("HealthDataManager", "Passive listener registered with ${dataTypes.size} types")
        } catch (e: Exception) {
            Log.e("HealthDataManager", "Failed to register passive listener", e)
        }
    }

    fun getLatestData(dataType: DataType<*, *>): String {
        return getLatestDataByName(dataType.name)
    }

    fun getLatestDataByName(name: String): String {
        return getLatestDataByNames(listOf(name))
    }

    fun getLatestDataByNames(names: List<String>): String {
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        for (name in names) {
            val value = prefs.getString(name, null)
            if (value != null && value != UNKNOWN_VALUE) return value
        }
        return UNKNOWN_VALUE
    }

    suspend fun getSleepDurationLast24h(): String {
        try {
            val endTime = Instant.now()
            val startTime = endTime.minus(Duration.ofDays(1))
            val response = healthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = SleepSessionRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(startTime, endTime)
                )
            )
            
            val totalDuration = response.records.sumOf { 
                Duration.between(it.startTime, it.endTime).toMinutes()
            }
            
            if (totalDuration == 0L) return UNKNOWN_VALUE
            
            val hours = totalDuration / 60
            val minutes = totalDuration % 60
            return if (hours > 0) String.format("%dh %dm", hours, minutes) else String.format("%dm", minutes)
        } catch (e: Exception) {
            Log.e("HealthDataManager", "Failed to read sleep records", e)
            return UNKNOWN_VALUE
        }
    }
}

class HealthPassiveListenerService : PassiveListenerService() {
    override fun onNewDataPointsReceived(dataPointContainer: DataPointContainer) {
        val updatedTypes = mutableSetOf<String>()
        val prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val editor = prefs.edit()

        val allDataPoints = mutableListOf<DataPoint<*>>()
        allDataPoints.addAll(dataPointContainer.sampleDataPoints)
        allDataPoints.addAll(dataPointContainer.intervalDataPoints)
        allDataPoints.addAll(dataPointContainer.cumulativeDataPoints)
        allDataPoints.addAll(dataPointContainer.statisticalDataPoints)

        allDataPoints.forEach { dataPoint ->
            val formatted = formatDataPoint(dataPoint)
            if (formatted != null) {
                val typeName = dataPoint.dataType.name
                editor.putString(typeName, formatted)
                updatedTypes.add(typeName)
                Log.d("HealthPassiveListener", "Updated $typeName: $formatted")
            }
        }
        editor.apply()

        if (updatedTypes.isNotEmpty()) {
            triggerComplicationUpdates(updatedTypes)
        }
    }

    private fun formatDataPoint(dataPoint: DataPoint<*>): String? {
        return try {
            val dataType = dataPoint.dataType
            val name = dataType.name
            
            when {
                name == DataType.HEART_RATE_BPM.name -> {
                    val sample = dataPoint as SampleDataPoint<Double>
                    String.format("%.0f", sample.value)
                }
                name == DataType.STEPS.name -> {
                    val cumulative = dataPoint as CumulativeDataPoint<Long>
                    cumulative.total.toString()
                }
                name == DataType.CALORIES_TOTAL.name -> {
                    val cumulative = dataPoint as CumulativeDataPoint<Double>
                    String.format("%.0f", cumulative.total)
                }
                name == DataType.DISTANCE.name -> {
                    val cumulative = dataPoint as CumulativeDataPoint<Double>
                    String.format("%.1f", cumulative.total / 1000.0)
                }
                name == DataType.FLOORS.name -> {
                    val cumulative = dataPoint as CumulativeDataPoint<Double>
                    String.format("%.0f", cumulative.total)
                }
                name == "SPO2" -> {
                    val sample = dataPoint as SampleDataPoint<Double>
                    String.format("%.0f%%", sample.value)
                }
                name == "RESPIRATORY_RATE" -> {
                    val sample = dataPoint as SampleDataPoint<Double>
                    String.format("%.0f/min", sample.value)
                }
                else -> null
            }
        } catch (e: Exception) {
            Log.e("HealthPassiveListener", "Error formatting ${dataPoint.dataType.name}", e)
            null
        }
    }

    private fun triggerComplicationUpdates(types: Set<String>) {
        val typeToService = mapOf(
            DataType.HEART_RATE_BPM.name to HeartRateComplicationService::class.java,
            DataType.STEPS.name to StepsComplicationService::class.java,
            "STEPS_DAILY" to StepsComplicationService::class.java,
            DataType.CALORIES_TOTAL.name to CaloriesComplicationService::class.java,
            "CALORIES_DAILY" to CaloriesComplicationService::class.java,
            DataType.DISTANCE.name to DistanceComplicationService::class.java,
            "DISTANCE_DAILY" to DistanceComplicationService::class.java,
            DataType.FLOORS.name to FloorsComplicationService::class.java,
            "FLOORS_DAILY" to FloorsComplicationService::class.java,
            "SPO2" to SpO2ComplicationService::class.java,
            "RESPIRATORY_RATE" to RespiratoryRateComplicationService::class.java
        )

        types.forEach { typeName ->
            typeToService[typeName]?.let { serviceClass ->
                val requester = ComplicationDataSourceUpdateRequester.create(
                    this, ComponentName(this, serviceClass)
                )
                requester.requestUpdateAll()
            }
        }
    }
}
