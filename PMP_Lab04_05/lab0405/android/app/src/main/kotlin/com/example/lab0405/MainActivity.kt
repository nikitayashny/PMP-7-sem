package com.example.lab0405

import android.content.Intent
import android.content.IntentFilter
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.BatteryManager
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.widget.Toast

class MainActivity : FlutterActivity() {
    private val CHANNEL_BATTERY = "com.example.battery/level"
    private val CHANNEL_LIGHT = "com.example.light/sensor"
    private val CHANNEL_EMAIL = "com.example.email/open"

    private lateinit var sensorManager: SensorManager
    private var lightSensor: Sensor? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        lightSensor = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_BATTERY).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                result.success(batteryLevel)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_LIGHT).setMethodCallHandler { call, result ->
            if (call.method == "getLightSensorData") {
                val lightData = getLightSensorData()
                result.success(lightData)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_EMAIL).setMethodCallHandler { call, result ->
            if (call.method == "openEmail") {
                val subject = call.argument<String>("subject")
                if (subject != null) {
                    openEmailApp(subject)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Недопустимая тема письма", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryIntent = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { intentFilter ->
            registerReceiver(null, intentFilter)
        }
        val level = batteryIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryIntent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        return if (scale > 0) (level * 100) / scale else -1
    }

    private fun getLightSensorData(): Map<String, Any> {
        val lightData = mutableMapOf<String, Any>()
        lightSensor?.let {
            lightData["lightLevel"] = it.maximumRange
        } ?: run {
            lightData["error"] = "Датчик света недоступен"
        }

        return lightData
    }

    private fun openEmailApp(subject: String) {
        val emailIntent = Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_SUBJECT, subject)
        }
        try {
            startActivity(Intent.createChooser(emailIntent, "Отправить через..."))
        } catch (e: Exception) {
            Toast.makeText(this, "Нет доступных приложений для отправки сообщения", Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            Toast.makeText(this, "Ошибка при открытии приложения: ${e.message}", Toast.LENGTH_SHORT).show()
            e.printStackTrace()
        }
    }
}