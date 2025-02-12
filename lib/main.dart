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

class TelegramCloneApp extends StatelessWidget {
  const TelegramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Telegram Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryBlue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.secondaryBlue,
            elevation: 0,
          ),
        ),
        home: const HomeScreen());
  }
}
