import 'package:flutter/material.dart';
import '../models/slot_model.dart';

class SlotDetailPage extends StatefulWidget {
  final Slot slot;
  final String loggedInUser;

  const SlotDetailPage({
    super.key,
    required this.slot,
    required this.loggedInUser,
  });

  @override
  State<SlotDetailPage> createState() => _SlotDetailPageState();
}

class _SlotDetailPageState extends State<SlotDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleJoin() {
    setState(() {
      if (widget.slot.players.contains(widget.loggedInUser)) {
        widget.slot.players.remove(widget.loggedInUser);
      } else if (!widget.slot.isFull) {
        widget.slot.players.add(widget.loggedInUser);
      }
    });
  }

  Color _getStatusColor() {
    switch (widget.slot.status) {
      case 'green': return const Color(0xFF43A047);
      case 'yellow': return const Color(0xFFFFD600);
      case 'orange': return const Color(0xFFFF6B35);
      default: return const Color(0xFFE53935);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool joined = widget.slot.players.contains(widget.loggedInUser);
    final statusColor = _getStatusColor();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F0F1A), Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white70, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.slot.time,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            widget.slot.statusLabel,
                            style: TextStyle(color: statusColor, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    // Capacity indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        '${widget.slot.players.length}/${widget.slot.capacity}',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capacity',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: widget.slot.fillRatio,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Players list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'PLAYERS',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${widget.slot.players.length})',
                      style: const TextStyle(
                        color: Color(0xFF00D4FF),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: widget.slot.players.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.group_outlined,
                                color: Colors.white.withOpacity(0.15), size: 48),
                            const SizedBox(height: 12),
                            Text(
                              'No players yet.\nBe the first to join!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: widget.slot.players.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final player = widget.slot.players[i];
                          final isMe = player == widget.loggedInUser;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? const Color(0xFF00D4FF).withOpacity(0.08)
                                  : Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isMe
                                    ? const Color(0xFF00D4FF).withOpacity(0.3)
                                    : Colors.white.withOpacity(0.07),
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: isMe
                                      ? const Color(0xFF00D4FF).withOpacity(0.2)
                                      : Colors.white.withOpacity(0.08),
                                  child: Text(
                                    player[0].toUpperCase(),
                                    style: TextStyle(
                                      color: isMe
                                          ? const Color(0xFF00D4FF)
                                          : Colors.white60,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  player,
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.white70,
                                    fontWeight: isMe
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                if (isMe) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00D4FF).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'You',
                                      style: TextStyle(
                                        color: Color(0xFF00D4FF),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Join/Leave button
              Padding(
                padding: const EdgeInsets.all(24),
                child: ScaleTransition(
                  scale: joined ? _pulseAnim : const AlwaysStoppedAnimation(1.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: widget.slot.isFull && !joined ? null : _toggleJoin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: joined
                            ? const Color(0xFFE53935).withOpacity(0.15)
                            : widget.slot.isFull
                                ? Colors.white12
                                : const Color(0xFF00D4FF),
                        foregroundColor: joined
                            ? const Color(0xFFE53935)
                            : widget.slot.isFull
                                ? Colors.white30
                                : const Color(0xFF0F0F1A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: joined
                                ? const Color(0xFFE53935).withOpacity(0.3)
                                : Colors.transparent,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            joined
                                ? Icons.exit_to_app
                                : widget.slot.isFull
                                    ? Icons.lock_outline
                                    : Icons.add,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            joined
                                ? 'Leave Game'
                                : widget.slot.isFull
                                    ? 'Slot Full'
                                    : 'Join Game',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
