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

class StepsComplicationService : SuspendingComplicationDataSourceService() {
    private val healthDataManager by lazy { HealthDataManager(applicationContext) }

    override suspend fun onComplicationRequest(request: ComplicationRequest): ComplicationData? {
        Log.d("PixelBridge", "Steps requested")
        healthDataManager.registerPassiveListener()
        
        val steps = healthDataManager.getLatestData(DataType.STEPS)
        val textStr = steps.toString()
        val numValue = textStr.replace(Regex("[^\d.]"), "").toFloatOrNull() ?: 0f
        
        val icon = MonochromaticImage.Builder(
            Icon.createWithResource(this, R.drawable.ic_steps)
        ).build()
        
        val text = PlainComplicationText.Builder(textStr).build()
        val desc = PlainComplicationText.Builder("Steps").build()

        return when (request.complicationType) {
            ComplicationType.GOAL_PROGRESS -> {
                GoalProgressComplicationData.Builder(
                    value = numValue.coerceIn(0f, 10000.0f),
                    targetValue = 10000.0f,
                    contentDescription = desc
                )
                .setText(text)
                .setMonochromaticImage(icon)
                .build()
            }
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = numValue.coerceIn(0f, 10000.0f),
                    min = 0f,
                    max = 10000.0f,
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
            Icon.createWithResource(this, R.drawable.ic_steps)
        ).build()
        val text = PlainComplicationText.Builder("5240").build()
        val desc = PlainComplicationText.Builder("Steps").build()

        return when (type) {
            ComplicationType.GOAL_PROGRESS -> {
                GoalProgressComplicationData.Builder(
                    value = 5240.0f.coerceIn(0f, 10000.0f),
                    targetValue = 10000.0f,
                    contentDescription = desc
                )
                .setText(text)
                .setMonochromaticImage(icon)
                .build()
            }
            ComplicationType.RANGED_VALUE -> {
                RangedValueComplicationData.Builder(
                    value = 5240.0f.coerceIn(0f, 10000.0f),
                    min = 0f,
                    max = 10000.0f,
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