import 'package:flutter/material.dart';
import '../models/slot_model.dart';
import '../widgets/slot_tiles.dart';
import 'slot_detail_page.dart';

class BookingGridPage extends StatefulWidget {
  final String sport;

  const BookingGridPage({super.key, required this.sport});

  @override
  State<BookingGridPage> createState() => _BookingGridPageState();
}

class _BookingGridPageState extends State<BookingGridPage> {
  final List<Slot> slots = List.generate(
    8,
    (i) => Slot(
      time: '${4 + i}:00 PM',
      capacity: 10,
      players: i % 2 == 0 ? ['A', 'B', 'C'] : [],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sport)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: slots.length,
        itemBuilder: (_, index) {
          return SlotTile(
            slot: slots[index],
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SlotDetailPage(slot: slots[index]),
                ),
              );
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
