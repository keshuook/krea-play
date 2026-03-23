import 'package:flutter/material.dart';
import 'auth/login_page.dart';

void main() {
  runApp(const KreaPlayApp());
}

class KreaPlayApp extends StatelessWidget {
  const KreaPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krea Play',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          brightness: Brightness.dark,
        ),
        fontFamily: 'SF Pro Display',
      ),
      home: const LoginPage(),
    );
  }
}
