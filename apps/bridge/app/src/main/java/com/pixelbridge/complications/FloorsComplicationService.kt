package com.pixelbridge.complications

import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class FloorsComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Floors requested")
        healthDataManager.registerPassiveListener()

        val floors = healthDataManager.getLatestData(DataType.FLOORS)

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(floors).build(),
            contentDescription = PlainComplicationText.Builder("Floors").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("5").build(),
            contentDescription = PlainComplicationText.Builder("Floors preview").build()
        ).build()
    }
}
