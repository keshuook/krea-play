import 'package:flutter/material.dart';

class KreaLogo extends StatelessWidget {
  const KreaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
            ),
          ),
          child: const Icon(
            Icons.sports_soccer,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Krea Play",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Campus Sports Coordination",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
