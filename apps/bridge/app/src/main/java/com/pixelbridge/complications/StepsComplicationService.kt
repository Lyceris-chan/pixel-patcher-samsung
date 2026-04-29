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

class StepsComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Steps requested")
        healthDataManager.registerPassiveListener()

        val steps = healthDataManager.getLatestData(DataType.STEPS)

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(steps).build(),
            contentDescription = PlainComplicationText.Builder("Steps").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("5240").build(),
            contentDescription = PlainComplicationText.Builder("Steps").build()
        ).build()
    }
}
