package com.pixelbridge.complications

import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class ActiveMinutesComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Active Minutes requested")
        healthDataManager.registerPassiveListener()

        // Health Services uses ACTIVE_EXERCISE_DURATION_DAILY or ACTIVE_EXERCISE_DURATION_TOTAL
        val activeMinutes = healthDataManager.getLatestDataByNames(listOf("ACTIVE_EXERCISE_DURATION_DAILY", "ACTIVE_EXERCISE_DURATION_TOTAL"))

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(activeMinutes).build(),
            contentDescription = PlainComplicationText.Builder("Active Minutes").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("45").build(),
            contentDescription = PlainComplicationText.Builder("Active Minutes preview").build()
        ).build()
    }
}
