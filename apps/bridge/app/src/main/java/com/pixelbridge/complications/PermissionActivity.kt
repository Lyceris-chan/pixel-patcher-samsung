package com.pixelbridge.complications

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.widget.TextView
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.StepsRecord
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

class PermissionActivity : Activity() {
    private val scope = MainScope()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val textView = TextView(this)
        textView.text = "Pixel Bridge Settings\n\nPermissions managed via ADB or Watch Settings."
        setContentView(textView)
        
        // Request Wear OS Sensor Permissions
        requestPermissions(arrayOf(
            android.Manifest.permission.BODY_SENSORS,
            android.Manifest.permission.BODY_SENSORS_BACKGROUND,
            android.Manifest.permission.ACTIVITY_RECOGNITION
        ), 1)

        // Request Health Connect Permissions
        scope.launch {
            try {
                val healthConnectClient = HealthConnectClient.getOrCreate(this@PermissionActivity)
                val permissions = setOf(
                    HealthPermission.getReadPermission(SleepSessionRecord::class),
                    HealthPermission.getReadPermission(StepsRecord::class)
                )
                
                val granted = healthConnectClient.permissionController.getGrantedPermissions()
                if (!granted.containsAll(permissions)) {
                    // TODO: Re-implement Health Connect permission request for specific library version
                    // In older versions this might be a different call or a manual Intent
                    Log.i("PermissionActivity", "Health Connect permissions missing")
                }
            } catch (e: Exception) {
                Log.e("PermissionActivity", "Health Connect not available", e)
            }
        }
    }
}
