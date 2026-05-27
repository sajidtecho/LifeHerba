import 'package:flutter/material.dart';
import 'modules/splash/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LifeHerbaApp());
}

class LifeHerbaApp extends StatelessWidget {
  const LifeHerbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeHerba',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
