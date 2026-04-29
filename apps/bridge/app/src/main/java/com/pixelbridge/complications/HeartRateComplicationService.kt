package com.pixelbridge.complications

import android.content.ComponentName
import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class HeartRateComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Heart Rate requested")
        healthDataManager.registerPassiveListener()
        
        val heartRate = healthDataManager.getLatestData(DataType.HEART_RATE_BPM)
        
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(heartRate).build(),
            contentDescription = PlainComplicationText.Builder("Heart Rate").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("72").build(),
            contentDescription = PlainComplicationText.Builder("Heart Rate").build()
        ).build()
    }
}
