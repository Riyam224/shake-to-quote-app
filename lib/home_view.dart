// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
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

  Timer? _autoChangeTimer;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _listenToShake();
    _startShakeDetection();
    _startAutoChange();
    _setupShakeAnimation();
  }

  void _setupShakeAnimation() {
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.elasticIn,
      ),
    );
  }

  void _startAutoChange() {
    _autoChangeTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _showRandomQuoteAndColor(isAutomatic: true);
    });
  }

  //  todo listen to shake
  void _listenToShake() {
    _shakeChannel.receiveBroadcastStream().listen((event) {
      if (event == "shake") {
        debugPrint("🔥 Shake detected");
        _showRandomQuoteAndColor(isAutomatic: false);
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

  void _showRandomQuoteAndColor({bool isAutomatic = false}) {
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

    if (isAutomatic) {
      _shakeController.forward(from: 0);
    }
  }

  // todo get contrasting color
  Color _getContrastingTextColor(Color bg) {
    final brightness =
        (bg.red * 0.299 + bg.green * 0.587 + bg.blue * 0.114) / 255;
    return brightness > 0.6 ? Colors.black : Colors.white;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
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

  @override
  void dispose() {
    _autoChangeTimer?.cancel();
    _shakeController.dispose();
    super.dispose();
  }
}
