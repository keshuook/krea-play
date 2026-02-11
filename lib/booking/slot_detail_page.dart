import 'package:flutter/material.dart';
import '../models/slot_model.dart';

class SlotDetailPage extends StatefulWidget {
  final Slot slot;

  const SlotDetailPage({super.key, required this.slot});

  @override
  State<SlotDetailPage> createState() => _SlotDetailPageState();
}

class _SlotDetailPageState extends State<SlotDetailPage> {
  final String userName = 'Aryan'; // mock logged-in user

  void toggleJoin() {
    setState(() {
      if (widget.slot.players.contains(userName)) {
        widget.slot.players.remove(userName);
      } else if (!widget.slot.isFull) {
        widget.slot.players.add(userName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool joined = widget.slot.players.contains(userName);

    return Scaffold(
      appBar: AppBar(title: Text(widget.slot.time)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Players (${widget.slot.players.length}):'),
            const SizedBox(height: 10),
            ...widget.slot.players.map((p) => Text(p)),
            const Spacer(),
            ElevatedButton(
              onPressed: widget.slot.isFull && !joined ? null : toggleJoin,
              child: Text(joined ? 'Leave Game' : 'Join Game'),
            ),
          ],
        ),
      ),
    );
  }
}
