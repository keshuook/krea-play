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
      theme: ThemeData(useMaterial3: true),
      home: const LoginPage(),
    );
  }
}
