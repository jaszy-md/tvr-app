import 'package:flutter/material.dart';
import 'package:tvr_app/navigation/app_navigation.dart';

void main() {
  runApp(const TVRApp());
}

class TVRApp extends StatelessWidget {
  const TVRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TVR App',
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
