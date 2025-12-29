# Shake to Quote ✨

<div align="center">

*A beautiful Flutter app that displays motivational quotes when you shake your device!*

**Built with Flutter & Native Android Integration**

</div>

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Demo](#demo)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Implementation Deep Dive](#implementation-deep-dive)
  - [Android Native Side (Kotlin)](#1-android-native-side-kotlin)
  - [Flutter Side (Dart)](#2-flutter-side-dart)
  - [Communication Flow](#3-communication-flow)
- [Project Structure](#project-structure)
- [Key Technologies](#key-technologies)
- [How It Works](#how-it-works)
- [Technical Highlights](#technical-highlights)
- [Future Enhancements](#future-enhancements)

---

## Overview

**Shake to Quote** is a delightful motivational quotes app that showcases the power of **Flutter Platform Channels** to bridge native Android functionality with Flutter's beautiful UI. When you shake your device, the app responds with a random motivational quote, beautiful pastel background colors, smooth animations, satisfying sound effects, and haptic feedback!

This project demonstrates:

- ✅ **MethodChannel** for Flutter-to-Native communication
- ✅ **EventChannel** for Native-to-Flutter event streaming
- ✅ **Android Sensor API** integration (Accelerometer)
- ✅ **MediaPlayer** for sound playback
- ✅ **Vibration/Haptic feedback** implementation
- ✅ **Custom shake detection algorithm**
- ✅ **Smooth animations** and **dynamic UI** updates

---

## Features

### Core Features

| Feature | Description |
|---------|-------------|
| **Shake Detection** | Uses accelerometer sensor to detect shake gestures with custom threshold (acceleration > 12) |
| **Auto-Change Mode** | Quotes automatically change every 2 seconds with subtle shake animation when idle |
| **Motivational Quotes** | Displays 11 inspiring quotes randomly selected from a curated collection |
| **Dynamic Backgrounds** | Beautiful background image with blur effect (8px blur radius) |
| **Pastel Popup Cards** | Quotes appear in rounded, shadowed cards with randomly generated pastel colors |
| **Smooth Animations** | Multiple animations: scale, fade, and shake effects for immersive experience |
| **Sound Effects** | Plays a custom shake sound (`shake_sound.mp3`) when shake is detected |
| **Haptic Feedback** | Device vibrates for 200ms to provide tactile confirmation |
| **Smart Text Color** | Automatically adjusts text color (black/white) based on background brightness |
| **Debouncing** | 1-second cooldown prevents excessive triggers during continuous shaking |

### Visual Features

- **Background Image with Blur**: Static background image (`assets/images/bg.jpg`) with 8px Gaussian blur and 10% dark overlay
- **Popup Card Design**: Quotes displayed in beautiful cards with:
  - 24px rounded corners
  - 30px shadow blur with 5px spread
  - 32px padding for comfortable spacing
  - Pastel colored background that changes with each quote
- **Alternating Text Style**: Bold typography (900 weight, 32px) with alternating word opacity for visual impact
- **Scale & Fade Transitions**: Quote cards scale in/out and fade in/out smoothly (800ms duration)
- **Shake Animation**: Automatic quotes trigger a horizontal shake effect using elastic curve
- **Letter Spacing**: 1.5px letter spacing for modern, impactful typography
- **Pastel Color Generation**: Dynamically generates beautiful pastel colors using HSL (Hue, Saturation, Lightness) algorithm
- **Contrast-Aware Text**: Calculates optimal text color for readability based on background brightness

---

## 💫 Demo

<div align="center">

## 🎥 App Demo — Shake to Get a Quote and enable sound

### Demo 1: Shake Detection with Sound & Haptics

<img src="demos/demo1.gif" width="480" alt="Demo 1 - Shake Detection" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.2); margin: 12px 0;">

*GIF showing the shake gesture triggering quote changes with color transitions*

<br/>

### Demo 2: Auto-Change & Visual Effects

<img src="demos/demo2.gif" width="480" alt="Demo 2 - Auto-Change & Visual Effects" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.2); margin: 12px 0;">

*GIF demonstration of auto-change feature and smooth animations*

<br/>

✨ *Shake your phone to get an instant dose of motivation!* ✨
🪄 *Beautiful color transitions and sound effects included!*

</div>

The app features:

1. Initial welcome screen with invitation to shake
2. Smooth color transitions when shaking
3. Random quote display with fade animation
4. Sound feedback and vibration on each shake
5. Adaptive text color for optimal readability

---

## Architecture

This app uses a **hybrid architecture** combining Flutter's cross-platform UI with native Android capabilities:

```
┌─────────────────────────────────────────────────────────────┐
│                       Flutter Layer                         │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  home_view.dart                                       │  │
│  │  • UI Components (AnimatedSwitcher, AnimatedContainer)│  │
│  │  • State Management (setState)                        │  │
│  │  • Quote & Color Logic                                │  │
│  │  • Platform Channel Communication                     │  │
│  └───────────────────────────────────────────────────────┘  │
│                            ↕                                │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Platform Channels                                    │  │
│  │  • EventChannel: shake_events (Native → Flutter)      │  │
│  │  • MethodChannel: shake_channel (Flutter → Native)    │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                             ↕
┌─────────────────────────────────────────────────────────────┐
│                    Native Android Layer                     │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  MainActivity.kt                                      │  │
│  │  • SensorManager (Accelerometer)                      │  │
│  │  • Shake Detection Algorithm                          │  │
│  │  • MediaPlayer (Sound)                                │  │
│  │  • Vibrator (Haptic Feedback)                         │  │
│  │  • EventChannel StreamHandler                         │  │
│  │  • MethodChannel MethodCallHandler                    │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.2 or higher)
- Android Studio or VS Code
- Physical Android device (emulator won't detect real shakes)
- Dart SDK

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Riyam224/shake-to-quote-app.git
   cd sshake-to-quote-app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Connect your physical Android device**
   - Enable USB debugging on your device
   - Connect via USB cable

4. **Run the app**

   ```bash
   flutter run
   ```

5. **Start shaking!**
   - Shake your device to see motivational quotes
   - Enjoy the sound effects and vibrations

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_core: ^4.2.0  # For future cloud features

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

---

## Implementation Deep Dive

### 1. Android Native Side (Kotlin)

**File**: [MainActivity.kt](android/app/src/main/kotlin/com/example/shake_to_quote/MainActivity.kt)

#### Setup Platform Channels

The MainActivity implements both **MethodChannel** and **EventChannel** to enable bidirectional communication:

```kotlin
class MainActivity : FlutterActivity(), SensorEventListener {
    private val METHOD = "shake_channel"
    private val EVENTS = "shake_events"

    private lateinit var sensorManager: SensorManager
    private var eventSink: EventChannel.EventSink? = null
    private var lastTime: Long = 0
    private var mediaPlayer: MediaPlayer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Setup MethodChannel for start/stop commands
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

        // Setup EventChannel for shake events
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
}
```

#### Accelerometer Sensor Management

The app registers a listener to the accelerometer sensor:

```kotlin
private fun startSensor() {
    sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
    val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
    sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_NORMAL)
}

private fun stopSensor() {
    sensorManager.unregisterListener(this)
}
```

**Key Points:**

- `SENSOR_DELAY_NORMAL`: Balances responsiveness with battery efficiency
- Proper lifecycle management: registers on start, unregisters on stop
- Uses `SensorEventListener` interface for real-time sensor data

#### Shake Detection Algorithm

The shake detection uses a physics-based approach:

```kotlin
override fun onSensorChanged(event: SensorEvent?) {
    if (event == null) return

    val x = event.values[0]
    val y = event.values[1]
    val z = event.values[2]

    // Calculate 3D acceleration magnitude
    val acceleration = Math.sqrt((x * x + y * y + z * z).toDouble())

    // Detect shake with threshold and debouncing
    if (acceleration > 12 && System.currentTimeMillis() - lastTime > 1000) {
        lastTime = System.currentTimeMillis()
        playShakeSound()    // Play sound
        vibratePhone()      // Vibrate device
        eventSink?.success("shake")  // Send event to Flutter
    }
}
```

**Algorithm Details:**

- **3D Acceleration**: `√(x² + y² + z²)` calculates total acceleration magnitude
- **Threshold**: 12 units (tuned for comfortable shake detection)
- **Debouncing**: 1000ms cooldown prevents multiple triggers
- **Multi-sensory feedback**: Sound + vibration + visual (via Flutter)

#### Sound Feedback Implementation

The MediaPlayer handles sound playback with smart resource management:

```kotlin
private fun playShakeSound() {
    if (mediaPlayer == null) {
        mediaPlayer = MediaPlayer.create(this, R.raw.shake_sound)
    }

    // Restart sound if already playing
    if (mediaPlayer?.isPlaying == true) {
        mediaPlayer?.seekTo(0)
    } else {
        mediaPlayer?.start()
    }
}

override fun onDestroy() {
    mediaPlayer?.release()
    mediaPlayer = null
    super.onDestroy()
}
```

**Features:**

- **Lazy initialization**: Creates MediaPlayer only when needed
- **Smart playback**: Restarts sound from beginning if already playing
- **Resource cleanup**: Releases MediaPlayer in `onDestroy()` to prevent memory leaks

**Sound File Location**: [android/app/src/main/res/raw/shake_sound.mp3](android/app/src/main/res/raw/shake_sound.mp3)

#### Haptic Feedback (Vibration)

The vibration implementation supports both modern and legacy Android versions:

```kotlin
private fun vibratePhone() {
    val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator

    // Android 8.0 (Oreo) and above
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
        val vibrationEffect = VibrationEffect.createOneShot(
            200,  // Duration in milliseconds
            VibrationEffect.DEFAULT_AMPLITUDE
        )
        vibrator.vibrate(vibrationEffect)
    } else {
        // Legacy support for older devices
        vibrator.vibrate(200)
    }
}
```

**Key Features:**

- **Version compatibility**: Supports Android API 26+ and below
- **Duration**: 200ms provides satisfying tactile feedback
- **Default amplitude**: Uses system-standard intensity

**Required Permission** (in [AndroidManifest.xml](android/app/src/main/AndroidManifest.xml)):

```xml
<uses-permission android:name="android.permission.VIBRATE" />
```

---

### 2. Flutter Side (Dart)

**File**: [lib/home_view.dart](lib/home_view.dart)

#### Platform Channels Setup

Flutter establishes communication channels with native code:

```dart
class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  static const EventChannel _shakeChannel = EventChannel('shake_events');
  static const MethodChannel _methodChannel = MethodChannel('shake_channel');

  String _quote = "Shake your phone to get motivated! 💪";
  Color currentColor = const Color(0xFFEBD4FB); // Initial pastel purple
  Color textColor = Colors.black;

  Timer? _autoChangeTimer;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  final List<String> _quotes = [
    "Believe in yourself 🌟",
    "Focus on progress, not perfection 🎯",
    "Small steps every day 🚶‍♀️",
    "You are stronger than you think 💪",
    "Keep going — success is coming ✨",
    "Never give up, keep going! 🌟",
    "The best way to predict the future is to create it. 🚀",
    "Success is a process, not a destination. 🌟",
    "The only limit to our realization of tomorrow will be our doubts of today. 🌟",
    "The future belongs to those who believe in the beauty of their dreams. 🌟",
    "Success is not final, failure is not fatal: it is the courage to continue that counts. 🌟",
  ];

  @override
  void initState() {
    super.initState();
    _listenToShake();
    _startShakeDetection();
    _startAutoChange();        // Start auto-change timer
    _setupShakeAnimation();    // Setup shake animation
  }

  void _setupShakeAnimation() {
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  void _startAutoChange() {
    _autoChangeTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _showRandomQuoteAndColor(isAutomatic: true);
    });
  }

  @override
  void dispose() {
    _autoChangeTimer?.cancel();
    _shakeController.dispose();
    super.dispose();
  }
}
```

#### EventChannel: Receiving Shake Events

Listen to shake events streamed from native Android:

```dart
void _listenToShake() {
  _shakeChannel.receiveBroadcastStream().listen((event) {
    if (event == "shake") {
      debugPrint("🔥 Shake detected");
      _showRandomQuoteAndColor(isAutomatic: false);  // Physical shake = no animation
    }
  });
}
```

**How it works:**

- `receiveBroadcastStream()`: Creates a broadcast stream from native events
- Listens continuously for "shake" events
- Triggers UI update when shake is detected

#### MethodChannel: Starting Shake Detection

Invoke native methods from Flutter:

```dart
Future<void> _startShakeDetection() async {
  try {
    await _methodChannel.invokeMethod("startShake");
  } on PlatformException catch (e) {
    debugPrint("Failed to start shake detection: ${e.message}");
  }
}
```

**Features:**

- Error handling with `PlatformException`
- Async/await for clean asynchronous code
- Graceful failure with debug logging

#### Dynamic Pastel Color Generation

Generate beautiful pastel colors using HSL color space:

```dart
Color _generatePastelColor() {
  final random = Random();
  final hue = random.nextDouble() * 360;           // Full color spectrum (0-360°)
  final saturation = 0.5 + random.nextDouble() * 0.3;  // Medium saturation (0.5-0.8)
  final lightness = 0.75 + random.nextDouble() * 0.15; // High lightness (0.75-0.9)

  return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
}
```

**Why HSL?**

- **Hue**: Controls the color type (red, blue, green, etc.)
- **Saturation**: Medium values (50-80%) create soft, muted colors
- **Lightness**: High values (75-90%) ensure pastel appearance
- More intuitive for generating pastel colors than RGB

#### Smart Text Color Contrast

Automatically choose black or white text for optimal readability:

```dart
Color _getContrastingTextColor(Color bg) {
  final brightness = (bg.red * 0.299 + bg.green * 0.587 + bg.blue * 0.114) / 255;
  return brightness > 0.6 ? Colors.black : Colors.white;
}
```

**Algorithm:**

- Uses **perceptual brightness** formula (weighted RGB)
- Human eyes are more sensitive to green (0.587) than red (0.299) or blue (0.114)
- Threshold of 0.6 provides good contrast balance

#### Update Quote and Color

Handle shake events with smooth state updates:

```dart
void _showRandomQuoteAndColor({bool isAutomatic = false}) {
  setState(() {
    // Get random quote (shuffle and pick first)
    _quote = (_quotes..shuffle()).first;

    // Generate new color (ensure it's different from current)
    Color newColor;
    do {
      newColor = _generatePastelColor();
    } while (newColor == currentColor);

    currentColor = newColor;
    textColor = _getContrastingTextColor(newColor);

    debugPrint("🎨 New pastel color: $currentColor, textColor: $textColor");
  });

  // Trigger shake animation only for automatic changes
  if (isAutomatic) {
    _shakeController.forward(from: 0);
  }
}
```

**Features:**

- **Random quote selection**: Shuffle entire list and pick first
- **Color diversity**: Ensures new color is different from current
- **Contrast calculation**: Updates text color for readability
- **State update**: Triggers UI rebuild with `setState()`

#### Beautiful Popup Card UI with Blur Background

Create smooth, elegant animations with multiple visual effects:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Background image layer
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Blur effect layer
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        // Quote card with animations
        Center(
          child: AnimatedBuilder(
            animation: _shakeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  sin(_shakeAnimation.value * pi * 4) * 5,
                  0,
                ),
                child: child,
              );
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey(_quote),
                margin: const EdgeInsets.symmetric(horizontal: 32.0),
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: currentColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: _buildStyledQuote(_quote),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStyledQuote(String quote) {
  final words = quote.split(' ');
  final List<TextSpan> spans = [];

  for (int i = 0; i < words.length; i++) {
    final word = words[i];
    final isEvenWord = i % 2 == 0;

    spans.add(
      TextSpan(
        text: word,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: isEvenWord ? textColor : textColor.withOpacity(0.4),
          height: 1.3,
          letterSpacing: 1.5,
        ),
      ),
    );

    if (i < words.length - 1) {
      spans.add(const TextSpan(text: ' '));
    }
  }

  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: spans),
  );
}
```

**Animation & Visual Components:**

1. **Stack Layout**
   - Layers background image, blur effect, and quote card
   - Enables complex visual composition

2. **Background with Blur**
   - `AssetImage` for background image
   - `BackdropFilter` with 8px Gaussian blur
   - 10% dark overlay for better contrast

3. **Shake Animation (Auto-change only)**
   - `AnimatedBuilder` with custom shake animation
   - Horizontal translation using sine wave
   - Elastic curve for natural bounce effect

4. **Scale & Fade Transition**
   - `ScaleTransition` makes card scale in/out
   - `FadeTransition` makes card fade in/out
   - Combined for smooth popup effect (800ms)

5. **Popup Card Design**
   - 24px rounded corners
   - 30px shadow blur with 5px spread
   - 32px padding for spacing
   - Pastel colored background

6. **Alternating Text Style**
   - Bold typography (900 weight, 32px)
   - Even words: full opacity
   - Odd words: 40% opacity
   - 1.5px letter spacing for impact

---

### 3. Communication Flow

Here's the complete data flow when you shake the device:

```
┌─────────────────────────────────────────────────────────────┐
│ 1. User Shakes Device                                       │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. Android Accelerometer Detects Movement                   │
│    • SensorEventListener.onSensorChanged() called           │
│    • Receives x, y, z acceleration values                   │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. Calculate 3D Acceleration Magnitude                      │
│    • acceleration = √(x² + y² + z²)                         │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 4. Check Shake Threshold & Debouncing                       │
│    • Is acceleration > 12?                                  │
│    • Has 1000ms passed since last shake?                    │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 5. Native Feedback (Parallel)                               │
│    • playShakeSound() → MediaPlayer plays shake_sound.mp3   │
│    • vibratePhone() → Vibrator triggers 200ms vibration     │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 6. Send Event to Flutter                                    │
│    • eventSink?.success("shake")                            │
│    • Event travels through EventChannel                     │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 7. Flutter Receives Event                                   │
│    • receiveBroadcastStream().listen() callback triggered   │
│    • Event data: "shake" string                             │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 8. Update App State                                         │
│    • _showRandomQuoteAndColor() called                      │
│    • Random quote selected: (_quotes..shuffle()).first      │
│    • Random pastel color generated via HSL algorithm        │
│    • Text color calculated for contrast                     │
│    • setState() called                                      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 9. UI Rebuild & Animation                                   │
│    • AnimatedContainer transitions to new background color  │
│    • AnimatedSwitcher fades out old quote                   │
│    • AnimatedSwitcher fades in new quote                    │
│    • Both animations run for 800ms with easeInOut curve     │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 10. User Sees Result                                        │
│     • New motivational quote displayed                      │
│     • Beautiful pastel background                           │
│     • Heard sound effect                                    │
│     • Felt vibration                                        │
│     • Smooth fade animations                                │
└─────────────────────────────────────────────────────────────┘
```

---

## Project Structure

```
shake_to_quote/
│
├── lib/
│   ├── main.dart                    # App entry point, MaterialApp configuration
│   └── home_view.dart               # Main UI, animations, auto-change, state management
│
├── android/
│   ├── app/src/main/
│   │   ├── kotlin/com/example/shake_to_quote/
│   │   │   └── MainActivity.kt      # Native Android shake detection
│   │   │
│   │   ├── res/raw/
│   │   │   └── shake_sound.mp3      # Shake sound effect
│   │   │
│   │   └── AndroidManifest.xml      # App permissions (VIBRATE)
│   │
│   └── build.gradle                 # Android build configuration
│
├── assets/
│   └── images/
│       └── bg.jpg                   # Background image
│
├── pubspec.yaml                     # Flutter dependencies & assets
└── README.md                        # This file!
```

---

## Key Technologies

### Flutter & Dart

- **Flutter SDK**: Cross-platform UI framework (^3.9.2)
- **Dart Language**: Modern, reactive programming with async/await
- **Material Design**: Beautiful, responsive UI components
- **Animations**: AnimatedSwitcher, AnimatedContainer, AnimatedBuilder, ScaleTransition, FadeTransition
- **Timer API**: Periodic timer for auto-change functionality
- **dart:ui**: ImageFilter for background blur effects

### Platform Channels

- **EventChannel**: Native → Flutter event streaming
- **MethodChannel**: Flutter → Native method invocation
- **Binary Messenger**: Low-level communication layer

### Native Android (Kotlin)

- **SensorManager**: Access device sensors
- **Accelerometer**: TYPE_ACCELEROMETER for motion detection
- **MediaPlayer**: Audio playback engine
- **Vibrator**: Haptic feedback service
- **VibrationEffect**: Modern vibration API (Android 8.0+)

### Algorithms & Math

- **3D Vector Magnitude**: `√(x² + y² + z²)` for acceleration
- **HSL Color Space**: Intuitive pastel color generation
- **Perceptual Brightness**: Weighted RGB for contrast calculation
- **Debouncing**: Time-based cooldown for shake detection

---

## How It Works

### Step-by-Step Breakdown

#### 1. App Initialization

When the app starts ([main.dart](lib/main.dart)):

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
```

#### 2. Platform Channel Setup

HomeView initializes platform channels:

```dart
@override
void initState() {
  super.initState();
  _listenToShake();         // Start listening to shake events
  _startShakeDetection();   // Tell Android to start sensor
}
```

#### 3. Native Sensor Registration

Android registers accelerometer listener:

```kotlin
private fun startSensor() {
    sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
    val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
    sensorManager.registerListener(this, sensor, SENSOR_DELAY_NORMAL)
}
```

#### 4. Shake Detection

When device moves, Android calculates acceleration:

```kotlin
val acceleration = Math.sqrt((x * x + y * y + z * z).toDouble())

if (acceleration > 12 && System.currentTimeMillis() - lastTime > 1000) {
    lastTime = System.currentTimeMillis()
    playShakeSound()
    vibratePhone()
    eventSink?.success("shake")
}
```

#### 5. Event Propagation

Event travels from Android to Flutter via EventChannel

#### 6. UI Update

Flutter receives event and updates UI:

```dart
void _showRandomQuoteAndColor() {
  setState(() {
    _quote = (_quotes..shuffle()).first;
    currentColor = _generatePastelColor();
    textColor = _getContrastingTextColor(currentColor);
  });
}
```

#### 7. Smooth Animation

AnimatedContainer and AnimatedSwitcher create smooth transitions

---

## Technical Highlights

### Android Native Excellence

✅ **Custom Platform Channel Implementation**

- Built from scratch without third-party shake detection packages
- Deep understanding of Flutter-Native communication

✅ **Sensor Management**

- Proper lifecycle with registration/unregistration
- Efficient battery usage with `SENSOR_DELAY_NORMAL`

✅ **Debouncing Algorithm**

- 1-second cooldown prevents excessive triggers
- Uses `lastTime` variable for time-based filtering

✅ **Multi-Sensory Feedback**

- Combined audio (MediaPlayer) and haptic (Vibrator) feedback
- Enhanced user experience with multiple feedback channels

✅ **MediaPlayer Lifecycle Management**

- Lazy initialization (created only when needed)
- Smart playback with `seekTo(0)` to restart sound
- Proper resource cleanup in `onDestroy()`

✅ **Android Version Compatibility**

- Modern `VibrationEffect.createOneShot()` API (Android 8.0+)
- Fallback to legacy `vibrate()` method for older versions
- Uses `Build.VERSION.SDK_INT` check

✅ **Accelerometer Algorithm**

- Calculates 3D acceleration magnitude: `√(x² + y² + z²)`
- Threshold of 12 units (empirically tuned)
- Considers all three axes for accurate detection

### Flutter Implementation Excellence

✅ **Error Handling**

- Platform exception handling with try-catch
- Graceful failure with debug logging

✅ **Stream-based Architecture**

- Uses EventChannel's `receiveBroadcastStream()`
- Real-time event processing
- Clean reactive programming pattern

✅ **Responsive UI**

- Centered layout with comfortable padding (24.0 horizontal)
- Full-screen background color changes
- Adaptive text styling

✅ **Animation System**

- `AnimatedSwitcher` with 800ms duration
- `ValueKey` based on content for proper triggers
- Smooth fade transitions with easeInOut curve

✅ **Color Generation**

- HSL color space for intuitive pastel generation
- Random but controlled (saturation 0.5-0.8, lightness 0.75-0.9)
- Ensures color variety by checking against current

✅ **Contrast Calculation**

- Perceptual brightness formula (weighted RGB)
- Automatic black/white text color selection
- Ensures readability on any background

✅ **State Management**

- Simple `setState()` for UI updates
- No external state management needed
- Clean, maintainable code
- Proper lifecycle management with `dispose()`

✅ **Auto-Change Feature**

- `Timer.periodic` updates quotes every 2 seconds
- Differentiates between physical shake and auto-change
- Triggers shake animation only for automatic changes
- Smooth, continuous quote rotation

✅ **Advanced Animations**

- Multiple simultaneous animations (scale, fade, shake)
- `AnimationController` with `SingleTickerProviderStateMixin`
- Sine wave-based shake motion with elastic curve
- Custom `transitionBuilder` for popup effect

✅ **Background Blur Effect**

- `BackdropFilter` with Gaussian blur (8px)
- Stack-based layering system
- Dark overlay for enhanced contrast
- Professional, modern aesthetic

---

## Future Enhancements

Here are some exciting features that could be added:

- [ ] **iOS Support**: Implement using Core Motion framework
- [ ] **Quote Favorites**: Allow users to bookmark favorite quotes
- [ ] **Social Sharing**: Share quotes on social media
- [ ] **Quote Categories**: Filter by themes (motivation, success, happiness)
- [ ] **Custom Sensitivity**: User-adjustable shake threshold
- [ ] **Sound Library**: Multiple sound effects to choose from
- [ ] **Vibration Patterns**: Custom haptic feedback patterns
- [ ] **Dark Mode**: System-aware theme switching
- [ ] **Quote History**: View previously shown quotes
- [ ] **Custom Quotes**: Users can add their own quotes
- [ ] **Daily Quote**: Push notification with daily inspiration
- [ ] **Shake Statistics**: Track shake count and favorite quotes

---

## Permissions

### Android Permissions

The app requires the following permission in [AndroidManifest.xml](android/app/src/main/AndroidManifest.xml):

```xml
<uses-permission android:name="android.permission.VIBRATE" />
```

**Why needed?**

- Enables haptic feedback when shake is detected
- Provides tactile confirmation of user interaction
- Enhances overall user experience

**Privacy note:** This is a low-risk permission that doesn't access any personal data.

---

## Assets

### Sound File

- **Location**: `android/app/src/main/res/raw/shake_sound.mp3`
- **Purpose**: Plays when shake is detected
- **Format**: MP3 audio file
- **Integration**: Loaded via `MediaPlayer.create(this, R.raw.shake_sound)`

**Note**: Make sure to place your custom sound file in the `res/raw/` directory. If the directory doesn't exist, create it manually.

---

## Troubleshooting

### Common Issues

**Issue**: Shake detection not working

- **Solution**: Make sure you're testing on a physical device, not an emulator
- **Solution**: Check that sensors are enabled in device settings

**Issue**: No sound playing

- **Solution**: Verify `shake_sound.mp3` exists in `android/app/src/main/res/raw/`
- **Solution**: Check device volume and ensure media volume is not muted

**Issue**: No vibration

- **Solution**: Verify VIBRATE permission in AndroidManifest.xml
- **Solution**: Check device vibration settings

**Issue**: Platform channel errors

- **Solution**: Ensure channel names match exactly in both Kotlin and Dart
- **Solution**: Run `flutter clean` and rebuild the app

---

## Development Timeline

This project showcases progressive learning and implementation:

1. **Initial Setup**: Flutter project structure and basic UI
2. **Platform Channels**: Implemented MethodChannel and EventChannel
3. **Sensor Integration**: Added accelerometer-based shake detection
4. **Sound Feedback**: Integrated MediaPlayer for audio playback
5. **Vibration Feedback**: Added haptic feedback with version compatibility
6. **UI Polish**: Implemented pastel colors and smooth animations
7. **Optimization**: Added debouncing and lifecycle management

---

## Learning Resources

### Platform Channels

- [Flutter Platform Channels Documentation](https://flutter.dev/docs/development/platform-integration/platform-channels)
- [Writing Custom Platform-Specific Code](https://flutter.dev/docs/development/platform-integration/platform-channels)

### Android Sensors

- [Android Sensor Framework](https://developer.android.com/guide/topics/sensors/sensors_overview)
- [Motion Sensors](https://developer.android.com/guide/topics/sensors/sensors_motion)

### Flutter Animations

- [Introduction to Animations](https://flutter.dev/docs/development/ui/animations)
- [AnimatedSwitcher Class](https://api.flutter.dev/flutter/widgets/AnimatedSwitcher-class.html)

---

## Contributing

This is a mentorship project, but suggestions and improvements are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Share your experience

---

## License

This project is part of the **Flutter Mentorship Program - Week 8**.

Built with love and Flutter by Riyam

---

## Acknowledgments

- Flutter team for excellent documentation
- Android developer community for sensor implementation guides
- Mentorship program for guidance and support

---

<div align="center">

**Made with Flutter & Kotlin**

*Keep shaking, keep learning!*

</div>
