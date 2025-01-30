import 'package:flutter/material.dart';

import '../screens/notification_screen.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouApp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const NotificationScreen(),
    );
  }
}
