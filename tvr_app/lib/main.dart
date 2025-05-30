import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvr_app/navigation/app_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF0A0A0A),
      systemNavigationBarDividerColor: Color(0xFF0A0A0A),
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
    ),
  );

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
