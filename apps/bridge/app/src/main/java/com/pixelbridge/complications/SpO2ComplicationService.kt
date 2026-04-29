package com.pixelbridge.complications

import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class SpO2ComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "SpO2 requested")
        healthDataManager.registerPassiveListener()

        val spo2 = healthDataManager.getLatestDataByName("SPO2")

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(spo2).build(),
            contentDescription = PlainComplicationText.Builder("Blood Oxygen").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("98%").build(),
            contentDescription = PlainComplicationText.Builder("SpO2 preview").build()
        ).build()
    }
}
