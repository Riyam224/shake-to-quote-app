# Shake to Quote

A Flutter application that displays motivational quotes when you shake your device! This project demonstrates native Android integration with Flutter using Platform Channels and device sensors.

## Features

- **Shake Detection**: Uses the device's accelerometer sensor to detect shake gestures
- **Random Motivational Quotes**: Displays inspiring quotes from a curated collection
- **Smooth Animations**: Quotes transition with a smooth fade animation
- **Native Android Integration**: Custom Kotlin code for sensor management
- **Platform Channels**: Bidirectional communication between Flutter and native Android

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

Key components:
- `SensorEventListener`: Listens to accelerometer sensor changes
- `EventChannel.StreamHandler`: Sends shake events to Flutter
- `MethodChannel.MethodCallHandler`: Handles Flutter method calls

### 2. Flutter Implementation (Dart)

The [home_view.dart](lib/home_view.dart) manages the UI and communication with native code:

- **EventChannel** (`shake_events`): Receives shake events from Android
- **MethodChannel** (`shake_channel`): Sends start/stop commands to Android
- **State Management**: Updates quote display on shake detection
- **AnimatedSwitcher**: Provides smooth quote transitions

### 3. Communication Flow

```
User Shakes Device
       ↓
Android Accelerometer Detects Movement
       ↓
MainActivity Calculates Acceleration
       ↓
EventChannel Sends "shake" Event
       ↓
Flutter Receives Event
       ↓
Random Quote Selected & Displayed
```

## Project Structure

```
lib/
├── main.dart           # App entry point and theme configuration
└── home_view.dart      # Main UI and shake detection logic

android/app/src/main/kotlin/
└── MainActivity.kt     # Native Android sensor implementation
```

## Key Technologies Used

- **Flutter**: Cross-platform UI framework
- **Platform Channels**: Flutter-Native communication
  - EventChannel for streaming shake events
  - MethodChannel for controlling sensor
- **Android Sensors API**: Accelerometer for shake detection
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

- **Custom Platform Channel Implementation**: Built from scratch without third-party shake detection packages
- **Sensor Management**: Proper lifecycle management of Android sensors
- **Debouncing**: 1-second cooldown prevents excessive quote changes
- **Error Handling**: Platform exception handling for sensor access failures
- **Responsive UI**: Centered layout with horizontal padding for readability

## Future Enhancements

- Add iOS support using Core Motion framework
- Implement quote favorites/bookmarking
- Add social sharing functionality
- Include quote categories/themes
- Implement custom sensitivity settings
- Add haptic feedback on shake detection

## Dependencies

- `flutter`: SDK
- `cupertino_icons`: ^1.0.8
- `firebase_core`: ^4.2.0 (for future cloud features)

## License

This project is part of the Flutter Mentorship program - Week 8.
