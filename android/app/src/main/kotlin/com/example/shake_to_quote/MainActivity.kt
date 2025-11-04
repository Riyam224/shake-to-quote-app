package com.example.shake_to_quote

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.content.Context
import android.media.MediaPlayer
import android.os.Vibrator
import android.os.VibrationEffect
class MainActivity : FlutterActivity(), SensorEventListener {

    private val METHOD = "shake_channel"
    private val EVENTS = "shake_events"

    private lateinit var sensorManager: SensorManager
    private var eventSink: EventChannel.EventSink? = null
    private var lastTime: Long = 0

    private var mediaPlayer: MediaPlayer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // ✅ Method channel to start/stop shake detection from Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startShake" -> {
                        startSensor()
                        result.success(null)
                    }
                    "stopShake" -> {
                        stopSensor()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        // ✅ Event channel to send shake events to Flutter
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENTS)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    startSensor()
                }

                override fun onCancel(arguments: Any?) {
                    stopSensor()
                    eventSink = null
                }
            })
    }

    private fun startSensor() {
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_NORMAL)
    }

    private fun stopSensor() {
        sensorManager.unregisterListener(this)
    }

    private  fun playShakeSound() {
        if (mediaPlayer == null) {
            mediaPlayer = MediaPlayer.create(this, R.raw.shake_sound)
        }
       // to avoid repeat the sound
        if (mediaPlayer?.isPlaying == true) {
            mediaPlayer?.seekTo(0)
        } else {
            mediaPlayer?.start()
        }

    }

    private fun vibratePhone() {
        val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator

        // للأندرويد 8.0 (Oreo) وما فوق نستخدم VibrationEffect
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val vibrationEffect = VibrationEffect.createOneShot(
                200, // المدة بالمللي ثانية (هنا 0.2 ثانية)
                VibrationEffect.DEFAULT_AMPLITUDE
            )
            vibrator.vibrate(vibrationEffect)
        } else {
            // للأجهزة القديمة
            vibrator.vibrate(200)
        }
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event == null) return

        val x = event.values[0]
        val y = event.values[1]
        val z = event.values[2]

        val acceleration = Math.sqrt((x * x + y * y + z * z).toDouble())

        // ⚡ Detect shake based on acceleration threshold
        if (acceleration > 12 && System.currentTimeMillis() - lastTime > 1000) {
            lastTime = System.currentTimeMillis()
             playShakeSound() // play sound 🎵
             vibratePhone() // play vibration
            eventSink?.success("shake") // send the event to flutter
        }


    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}


//    destroy the media player ✨
    override fun onDestroy() {
        mediaPlayer?.release()
        mediaPlayer = null
        super.onDestroy()
    }


}
