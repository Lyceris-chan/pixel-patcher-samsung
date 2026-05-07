package com.pixelbridge.complications

import android.app.PendingIntent
import android.content.Context
import android.content.Intent

object ComplicationIntents {
    private const val SAMSUNG_HEALTH_PACKAGE = "com.samsung.android.wear.shealth"

    fun healthTapIntent(context: Context): PendingIntent? {
        val launchIntent = context.packageManager.getLaunchIntentForPackage(SAMSUNG_HEALTH_PACKAGE)
            ?: return null
        launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        return PendingIntent.getActivity(
            context,
            0,
            launchIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }
}
