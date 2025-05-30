import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvr_app/navigation/app_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Forceer zwarte navigation bar met lichte iconen
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF0A0A0A), // Zwarte achtergrond
      systemNavigationBarDividerColor: Color(0xFF0A0A0A), // Geen rand
      systemNavigationBarIconBrightness: Brightness.light, // Witte iconen
      systemNavigationBarContrastEnforced:
          false, // Voorkom automatische aanpassing
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
