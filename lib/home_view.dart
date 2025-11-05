// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // todo event and method channels
  static const EventChannel _shakeChannel = EventChannel('shake_events');
  static const MethodChannel _methodChannel = MethodChannel('shake_channel');

  // todo initial text
  String _quote = "Shake your phone to get motivated! 💪";

  //  todo
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

  //  todo initial colors
  Color currentColor = const Color(0xFFEBD4FB); // pastel purple
  Color textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _listenToShake();
    _startShakeDetection();
  }

  //  todo listen to shake
  void _listenToShake() {
    _shakeChannel.receiveBroadcastStream().listen((event) {
      if (event == "shake") {
        debugPrint("🔥 Shake detected");
        _showRandomQuoteAndColor();
      }
    });
  }

  //  todo start detection
  Future<void> _startShakeDetection() async {
    try {
      await _methodChannel.invokeMethod("startShake");
    } on PlatformException catch (e) {
      debugPrint("Failed to start shake detection: ${e.message}");
    }
  }

  /// 🎨 generate random colors
  Color _generatePastelColor() {
    final random = Random();
    final hue = random.nextDouble() * 360; // زاوية اللون
    final saturation = 0.5 + random.nextDouble() * 0.3; // درجة التشبع (متوسطة)
    final lightness = 0.75 + random.nextDouble() * 0.15; // تفتيح اللون (pastel)

    // convert  HSL to  RGB
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  void _showRandomQuoteAndColor() {
    setState(() {
      _quote = (_quotes..shuffle()).first;

      Color newColor;
      do {
        newColor = _generatePastelColor();
      } while (newColor == currentColor);

      currentColor = newColor;
      textColor = _getContrastingTextColor(newColor);

      debugPrint("🎨 New pastel color: $currentColor, textColor: $textColor");
    });
  }

  // todo get contrasting color
  Color _getContrastingTextColor(Color bg) {
    final brightness =
        (bg.red * 0.299 + bg.green * 0.587 + bg.blue * 0.114) / 255;
    return brightness > 0.6 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        key: ValueKey(currentColor.value),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        color: currentColor,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: Padding(
              key: ValueKey(_quote),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                _quote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
