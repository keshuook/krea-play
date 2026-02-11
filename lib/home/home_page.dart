import 'package:flutter/material.dart';
import '../booking/booking_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> sports = const [
    'Football',
    'Basketball',
    'Volleyball',
    'Badminton',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Sport')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: sports.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingGridPage(sport: sports[index]),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(
                  sports[index],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
