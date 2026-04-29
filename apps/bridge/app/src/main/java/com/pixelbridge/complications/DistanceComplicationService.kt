package com.pixelbridge.complications

import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class DistanceComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Distance requested")
        healthDataManager.registerPassiveListener()

        val distance = healthDataManager.getLatestData(DataType.DISTANCE)

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(distance).build(),
            contentDescription = PlainComplicationText.Builder("Distance").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("3.2").build(),
            contentDescription = PlainComplicationText.Builder("Distance preview").build()
        ).build()
    }
}
