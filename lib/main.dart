import 'package:flutter/material.dart';
import 'package:shake_to_quote/home_view.dart';

void main() { 
  runApp(const ShakeToQuoteApp());
}

class ShakeToQuoteApp extends StatelessWidget {
  const ShakeToQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shake to Quote',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.purple,
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
