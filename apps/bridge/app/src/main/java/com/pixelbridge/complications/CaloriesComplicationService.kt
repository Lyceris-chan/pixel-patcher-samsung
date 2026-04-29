package com.pixelbridge.complications

import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService

class CaloriesComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Calories requested")
        healthDataManager.registerPassiveListener()

        val calories = healthDataManager.getLatestData(DataType.CALORIES_TOTAL)

        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder(calories).build(),
            contentDescription = PlainComplicationText.Builder("Calories").build()
        ).build()
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        return ShortTextComplicationData.Builder(
            text = PlainComplicationText.Builder("450").build(),
            contentDescription = PlainComplicationText.Builder("Calories preview").build()
        ).build()
    }
}
