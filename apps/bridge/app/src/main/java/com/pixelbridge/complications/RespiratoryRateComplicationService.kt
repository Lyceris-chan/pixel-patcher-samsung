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

class RespiratoryRateComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Resp Rate requested")
        healthDataManager.registerPassiveListener()
        
        val value = healthDataManager.getLatestDataByName("RESPIRATORY_RATE")
        val textStr = ue.toString()
        val numValue = textStr.replace(Regex("[^\d.]"), "").toFloatOrNull() ?: 0f
        
        val icon = MonochromaticImage.Builder(
            Icon.createWithResource(this, R.drawable.ic_generic_health)
        ).build()
        
        val text = PlainComplicationText.Builder(textStr).build()
        val desc = PlainComplicationText.Builder("Resp Rate").build()

        return when (request.complicationType) {
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = numValue.coerceIn(0f, 40.0f),
                    min = 0f,
                    max = 40.0f,
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
        val text = PlainComplicationText.Builder("16").build()
        val desc = PlainComplicationText.Builder("Resp Rate").build()

        return when (type) {
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = 16.0f.coerceIn(0f, 40.0f),
                    min = 0f,
                    max = 40.0f,
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