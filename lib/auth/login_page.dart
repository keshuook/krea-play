import 'package:flutter/material.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  void login() {
  final email = emailController.text;

  if (!(email.endsWith('@krea.edu.in') || email.endsWith('@krea.ac.in'))) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please use your Krea ID')),
    );
    return;
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const HomePage()),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Krea Play Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Krea Email',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
