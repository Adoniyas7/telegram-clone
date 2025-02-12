import 'package:flutter/material.dart';
import 'package:telegram_clone/constants/colors.dart';
import 'screens/home_screen.dart';
import 'package:telegram_clone/providers/story_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StoryProvider(),
      child: const TelegramCloneApp(),
    ),
  );
}

class TelegramCloneApp extends StatefulWidget {
  const TelegramCloneApp({Key? key}) : super(key: key);

  @override
  State<TelegramCloneApp> createState() => _TelegramCloneAppState();
}

class _TelegramCloneAppState extends State<TelegramCloneApp> {
  bool _isDarkMode = false; // State variable for dark mode

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Clone',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode
          ? ThemeData.dark() // Use dark theme
          : ThemeData(
              primaryColor: AppColors.primaryBlue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.secondaryBlue,
                elevation: 0,
              ),
            ),
      home: HomeScreen(
        isDarkMode: _isDarkMode, // Pass dark mode state
        toggleDarkMode: _toggleDarkMode, // Pass toggle function
      ),
    );
  }
}