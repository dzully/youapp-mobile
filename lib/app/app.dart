import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/notification_screen.dart';
import '../screens/auth/login_page.dart';
import '../screens/auth/register_page.dart';
import '../bindings/initial_binding.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YouApp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: InitialBinding(),
      getPages: [
        GetPage(name: '/', page: () => const NotificationScreen()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
      ],
      home: const NotificationScreen(),
    );
  }
}
