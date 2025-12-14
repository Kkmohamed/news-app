import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/localdata/preferences_manager.dart';
import 'package:news_app/core/theme/light_theme.dart';

import 'package:news_app/features/splash/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  // await PreferencesManager().clear();
  runApp(
    NewsApp(),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
