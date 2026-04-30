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

class HeartRateComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Heart Rate requested")
        healthDataManager.registerPassiveListener()
        
        val heartRate = healthDataManager.getLatestData(DataType.HEART_RATE_BPM)
        val textStr = heartRate.toString()
        val numValue = textStr.replace(Regex("[^\d.]"), "").toFloatOrNull() ?: 0f
        
        val icon = MonochromaticImage.Builder(
            Icon.createWithResource(this, R.drawable.ic_heart)
        ).build()
        
        val text = PlainComplicationText.Builder(textStr).build()
        val desc = PlainComplicationText.Builder("Heart Rate").build()

        return when (request.complicationType) {
            ComplicationType.GOAL_PROGRESS -> {
                GoalProgressComplicationData.Builder(
                    value = numValue.coerceIn(0f, 220.0f),
                    targetValue = 220.0f,
                    contentDescription = desc
                )
                .setText(text)
                .setMonochromaticImage(icon)
                .build()
            }
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = numValue.coerceIn(0f, 220.0f),
                    min = 0f,
                    max = 220.0f,
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
            Icon.createWithResource(this, R.drawable.ic_heart)
        ).build()
        val text = PlainComplicationText.Builder("72").build()
        val desc = PlainComplicationText.Builder("Heart Rate").build()

        return when (type) {
            ComplicationType.GOAL_PROGRESS -> {
                GoalProgressComplicationData.Builder(
                    value = 72.0f.coerceIn(0f, 220.0f),
                    targetValue = 220.0f,
                    contentDescription = desc
                )
                .setText(text)
                .setMonochromaticImage(icon)
                .build()
            }
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = 72.0f.coerceIn(0f, 220.0f),
                    min = 0f,
                    max = 220.0f,
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