# Shake to Quote

A Flutter application that displays motivational quotes when you shake your device! This project demonstrates native Android integration with Flutter using Platform Channels and device sensors.

## Features

- **Shake Detection**: Uses the device's accelerometer sensor to detect shake gestures with custom threshold
- **Random Motivational Quotes**: Displays inspiring quotes from a curated collection of 16 quotes
- **Dynamic Background Colors**: Background color changes randomly with each shake from a palette of 7 colors
- **Smooth Animations**: Quotes transition with a smooth 500ms fade animation using AnimatedSwitcher
- **Sound Feedback**: Plays a custom shake sound effect when shake is detected
- **Haptic Feedback (Vibration)**: Device vibrates for 200ms when shake is detected for better user experience
- **Native Android Integration**: Custom Kotlin code for sensor management and feedback
- **Platform Channels**: Bidirectional communication between Flutter and native Android
  - **EventChannel**: Streams shake events from Android to Flutter
  - **MethodChannel**: Controls shake detection start/stop from Flutter

## How It Works

### 1. Native Android Implementation (Kotlin)

The [MainActivity.kt](android/app/src/main/kotlin/com/example/shake_to_quote/MainActivity.kt) implements shake detection using Android's accelerometer sensor:

- **SensorManager**: Manages access to the device's accelerometer
- **Shake Detection Algorithm**:
  - Calculates total acceleration using `√(x² + y² + z²)`
  - Triggers shake event when acceleration > 12
  - Prevents multiple triggers with 1-second cooldown
- **Event Channel**: Broadcasts shake events to Flutter as a stream
- **Method Channel**: Provides start/stop shake detection methods

#### Sound and Vibration Feedback

Added sensory feedback to enhance user experience:

- **MediaPlayer Integration**:
  - Plays `shake_sound.mp3` from `res/raw/` folder when shake is detected
  - Smart playback: resets sound to beginning if already playing (using `seekTo(0)`)
  - Proper lifecycle management: releases MediaPlayer resources in `onDestroy()`

- **Vibration Feedback**:
  - Triggers 200ms vibration on shake detection via `vibratePhone()` function
  - Uses `VibrationEffect.createOneShot()` API for Android 8.0 (Oreo/API 26) and above
  - Falls back to legacy `vibrate(200)` method for older Android versions
  - Uses `DEFAULT_AMPLITUDE` for consistent vibration intensity
  - Provides haptic confirmation of shake detection
  - Called immediately when shake is detected (line 111 in MainActivity.kt)

Key components:

- `SensorEventListener`: Listens to accelerometer sensor changes
- `EventChannel.StreamHandler`: Sends shake events to Flutter
- `MethodChannel.MethodCallHandler`: Handles Flutter method calls
- `MediaPlayer`: Manages shake sound playback
- `Vibrator`: Provides haptic feedback

### 2. Flutter Implementation (Dart)

The [home_view.dart](lib/home_view.dart) manages the UI and communication with native code:

#### Platform Channels Setup

- **EventChannel** (`shake_events`): Receives shake events from Android as a broadcast stream
- **MethodChannel** (`shake_channel`): Sends start/stop commands to Android native code

#### UI Features & State Management

- **Quote Display**: Shows motivational quotes with centered alignment and custom text styling
- **Dynamic Background**: Changes background color randomly from a palette of 7 pastel colors:
  - Cream Yellow (`#F2E9C9`)
  - Mint Green (`#A8DCC3`)
  - Sky Blue (`#B7DDEE`)
  - Peach (`#F1D0A5`)
  - Light Purple (`#ECB9F5`)
  - Coral Red (`#E6A7A7`)
  - Light Yellow (`#FAFAB3`)
- **AnimatedSwitcher**: Provides smooth 500ms fade transition between quotes
- **Random Selection**: Shuffles quotes array and picks random color on each shake
- **Initial State**: Shows "Shake your phone to get motivated! 💪" with a warm peach background

#### App Configuration ([main.dart](lib/main.dart))

- **Theme**: Purple primary color scheme
- **Typography**: Custom text theme with 22px font size, medium weight, and purple color
- **Debug Mode**: Debug banner disabled for cleaner UI

### 3. Communication Flow

```text
User Shakes Device
       ↓
Android Accelerometer Detects Movement (SensorEventListener)
       ↓
MainActivity Calculates Acceleration: √(x² + y² + z²)
       ↓
Shake Detected (acceleration > 12 && cooldown > 1000ms)
       ↓
Native Side: Play Sound (MediaPlayer) + Vibrate (200ms)
       ↓
EventChannel Sends "shake" Event to Flutter
       ↓
Flutter Receives Event in receiveBroadcastStream()
       ↓
setState() Called: Random Quote Selected + Random Color Picked
       ↓
UI Updates with AnimatedSwitcher Animation (500ms fade)
```

## Project Structure

```text
lib/
├── main.dart           # App entry point and theme configuration
└── home_view.dart      # Main UI and shake detection logic

android/app/src/main/kotlin/
└── MainActivity.kt     # Native Android sensor implementation

android/app/src/main/res/raw/
└── shake_sound.mp3     # Sound effect played on shake detection
```

## Key Technologies Used

- **Flutter**: Cross-platform UI framework
- **Platform Channels**: Flutter-Native communication
  - EventChannel for streaming shake events
  - MethodChannel for controlling sensor
- **Android Sensors API**: Accelerometer for shake detection
- **Android Media APIs**:
  - MediaPlayer for sound playback
  - Vibrator/VibrationEffect for haptic feedback
- **Kotlin**: Native Android implementation

## Quote Collection

The app includes 16 motivational quotes covering themes like:

- Self-belief and confidence
- Progress and perseverance
- Goal achievement
- Dream realization
- Hard work and dedication

## Setup & Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run the app on an Android device (emulator won't detect shakes)

   ```bash
   flutter run
   ```

## Requirements

- Flutter SDK (^3.9.2)
- Android device (physical device recommended for shake testing)
- Dart SDK

## How to Use

1. Launch the app on your Android device
2. Shake your phone
3. Watch as a new motivational quote appears with a smooth animation
4. Keep shaking for more inspiration!

## Technical Highlights

### Android Native Implementation

- **Custom Platform Channel Implementation**: Built from scratch without third-party shake detection packages
- **Sensor Management**: Proper lifecycle management of Android sensors with registration/unregistration
- **Debouncing**: 1-second cooldown (`lastTime` variable) prevents excessive quote changes
- **Multi-Sensory Feedback**: Combined audio (MediaPlayer) and haptic (Vibrator) feedback for enhanced UX
- **MediaPlayer Lifecycle Management**:
  - Lazy initialization (created only when first needed)
  - Smart playback with `seekTo(0)` to restart sound if already playing
  - Proper resource cleanup in `onDestroy()` method
- **Android Version Compatibility**:
  - Supports modern `VibrationEffect.createOneShot()` API (Android 8.0+)
  - Falls back to legacy `vibrate()` method for older Android versions
  - Uses `Build.VERSION.SDK_INT` check for compatibility
- **Accelerometer Algorithm**:
  - Calculates 3D acceleration magnitude: `√(x² + y² + z²)`
  - Threshold of 12 units for shake detection
  - `SENSOR_DELAY_NORMAL` for efficient battery usage

### Flutter Implementation

- **Error Handling**: Platform exception handling with try-catch for sensor access failures
- **Stream-based Architecture**: Uses EventChannel's `receiveBroadcastStream()` for real-time events
- **Responsive UI**:
  - Centered layout with horizontal padding (16.0) for readability
  - Full-screen background color changes
  - Text styling from MaterialApp theme
- **Animation System**:
  - `AnimatedSwitcher` with 500ms duration
  - Uses `ValueKey` based on quote content for proper animation triggers
  - Smooth fade transition between quotes
- **Random Generation**:
  - Quote selection via list shuffle: `(_quotes..shuffle()).first`
  - Color selection via `Random().nextInt(colors.length)`
  - Ensures variety in user experience
- **State Management**: Simple `setState()` for UI updates, no external state management needed

## Future Enhancements

- Add iOS support using Core Motion framework
- Implement quote favorites/bookmarking
- Add social sharing functionality
- Include quote categories/themes
- Implement custom sensitivity settings
- Add customizable sound effects and vibration patterns

## Implementation Summary

This project showcases a complete implementation of native Android sensor integration with Flutter:

### Android Side ([MainActivity.kt](android/app/src/main/kotlin/com/example/shake_to_quote/MainActivity.kt))

1. **Sensors**: Accelerometer sensor for shake detection
2. **Sound**: MediaPlayer integration with `shake_sound.mp3` audio file
3. **Vibration**: Vibrator service with 200ms haptic feedback
4. **Platform Channels**:
   - MethodChannel for start/stop control
   - EventChannel for streaming shake events
5. **Lifecycle Management**: Proper sensor registration/unregistration and MediaPlayer cleanup

### Flutter Side ([lib/home_view.dart](lib/home_view.dart) & [lib/main.dart](lib/main.dart))

1. **UI Components**:
   - AnimatedSwitcher for smooth transitions
   - Dynamic background color changes (7 color palette)
   - Centered text layout with custom styling
2. **State Management**: Local state with setState()
3. **Random Selection**: Both quotes and colors randomized on each shake
4. **Theme Configuration**: Purple theme with custom typography
5. **Platform Channel Communication**: EventChannel listener and MethodChannel invocation

### Assets

- **Sound File**: [android/app/src/main/res/raw/shake_sound.mp3](android/app/src/main/res/raw/shake_sound.mp3) - Custom shake sound effect

## Dependencies

- `flutter`: SDK (^3.9.2)
- `cupertino_icons`: ^1.0.8
- `firebase_core`: ^4.2.0 (for future cloud features)

## License

This project is part of the Flutter Mentorship program - Week 8.
