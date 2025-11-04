import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // todo handle events
  static const EventChannel _shakeChannel = EventChannel('shake_events');
  static const MethodChannel _methodChannel = MethodChannel('shake_channel');

  // todo first showed text
  String _quote = "Shake your phone to get motivated! 💪";
  // todo quotes
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
    "The only way to do great work is to love what you do. 🌟",
    "Success is not final, failure is not fatal: it is the courage to continue that counts. 🌟",
    "The future belongs to those who believe in the beauty of their dreams. 🌟",
    "The only way to do great work is to love what you do. 🌟",
    "Success is not final, failure is not fatal: it is the courage to continue that counts. 🌟",
    "The future belongs to those who believe in the beauty of their dreams. 🌟",
  ];

  // todo initial color
  Color currentColor = const Color.fromARGB(255, 230, 203, 255);

  @override
  void initState() {
    super.initState();
    _listenToShake();
    _startShakeDetection();
  }

  void _listenToShake() {
    _shakeChannel.receiveBroadcastStream().listen((event) {
      if (event == "shake") {
        _showRandomQuoteAndColor();
      }
    });
  }

  Future<void> _startShakeDetection() async {
    try {
      await _methodChannel.invokeMethod("startShake");
    } on PlatformException catch (e) {
      debugPrint("Failed to start shake detection: ${e.message}");
    }
  }

  void _showRandomQuoteAndColor() {
    setState(() {
      _quote = (_quotes..shuffle()).first;

      // Generate a random color
      Color newColor;
      do {
        newColor = Color.fromARGB(
          255,
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
        );
      } while (newColor == currentColor);

      currentColor = newColor;
    });
  }

  // todo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        color: currentColor,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _quote,
                key: ValueKey(_quote),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
