import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/localdata/preferences_manager.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(Duration(seconds: 2));
    final bool onBoardingCompleted =
        PreferencesManager().getBool('onboarding_complete') ?? false;
    final bool isLoggedIn =
        PreferencesManager().getBool('is_logged_in') ?? false;

    if (!onBoardingCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        width: double.infinity,
        'assets/images/splash.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
