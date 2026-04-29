package com.pixelbridge.complications

import android.util.Log
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class SleepComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Sleep requested")
        
        val sleepDuration = healthDataManager.getSleepDurationLast24h()

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(sleepDuration).build(),
            contentDescription = PlainComplicationText.Builder("Sleep Duration").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("7h 20m").build(),
            contentDescription = PlainComplicationText.Builder("Sleep preview").build()
        ).build()
    }
}
