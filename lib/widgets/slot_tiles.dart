import 'package:flutter/material.dart';
import '../models/slot_model.dart';

class SlotTile extends StatelessWidget {
  final Slot slot;
  final VoidCallback onTap;

  const SlotTile({super.key, required this.slot, required this.onTap});

  Color _getColor() {
    if (slot.status == 'green') return Colors.green;
    if (slot.status == 'yellow') return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _getColor(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            slot.time,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
