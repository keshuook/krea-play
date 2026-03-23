import 'package:flutter/material.dart';
import '../models/slot_model.dart';

class SlotTile extends StatelessWidget {
  final Slot slot;
  final VoidCallback onTap;

  const SlotTile({super.key, required this.slot, required this.onTap});

  Color _getColor() {
    switch (slot.status) {
      case 'green':
        return const Color(0xFF43A047);
      case 'yellow':
        return const Color(0xFFFFD600);
      case 'orange':
        return const Color(0xFFFF6B35);
      case 'red':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF43A047);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final bool full = slot.isFull;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: full
              ? Colors.white.withOpacity(0.03)
              : color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: full ? Colors.white12 : color.withOpacity(0.4),
            width: 1.2,
          ),
        ),
        child: Stack(
          children: [
            // Fill bar at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                widthFactor: slot.fillRatio,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slot.time,
                    style: TextStyle(
                      color: full ? Colors.white30 : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: full ? Colors.white10 : color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      slot.statusLabel,
                      style: TextStyle(
                        color: full ? Colors.white30 : color,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
