package com.pixelbridge.complications

import android.util.Log
import androidx.health.services.client.data.DataType
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.data.GoalProgressComplicationData
import androidx.wear.watchface.complications.data.RangedValueComplicationData
import androidx.wear.watchface.complications.data.MonochromaticImage
import android.graphics.drawable.Icon
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import androidx.wear.watchface.complications.datasource.SuspendingComplicationDataSourceService
import com.pixelbridge.complications.R

class FloorsComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Floors requested")
        healthDataManager.registerPassiveListener()
        
        val floors = healthDataManager.getLatestData(DataType.FLOORS)
        val textStr = floors.toString()
        val numValue = textStr.replace(Regex("[^\d.]"), "").toFloatOrNull() ?: 0f
        
        val icon = MonochromaticImage.Builder(
            Icon.createWithResource(this, R.drawable.ic_generic_health)
        ).build()
        
        val text = PlainComplicationText.Builder(textStr).build()
        val desc = PlainComplicationText.Builder("Floors").build()

        return when (request.complicationType) {
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = numValue.coerceIn(0f, 50.0f),
                    min = 0f,
                    max = 50.0f,
                    contentDescription = desc
                )
                .setText(text)
                .setMonochromaticImage(icon)
                .build()
            }
            else -> {
                ShortTextComplicationData.Builder(
                    text = text,
                    contentDescription = desc
                )
                .setMonochromaticImage(icon)
                .build()
            }
        }
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? {
        val icon = MonochromaticImage.Builder(
            Icon.createWithResource(this, R.drawable.ic_generic_health)
        ).build()
        val text = PlainComplicationText.Builder("12").build()
        val desc = PlainComplicationText.Builder("Floors").build()

        return when (type) {
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = 12.0f.coerceIn(0f, 50.0f),
                    min = 0f,
                    max = 50.0f,
                    contentDescription = desc
                )
                .setText(text)
                .setMonochromaticImage(icon)
                .build()
            }
            else -> {
                ShortTextComplicationData.Builder(
                    text = text,
                    contentDescription = desc
                )
                .setMonochromaticImage(icon)
                .build()
            }
        }
    }
}