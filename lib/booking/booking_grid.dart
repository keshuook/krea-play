import 'package:flutter/material.dart';
import '../models/slot_model.dart';
import '../widgets/slot_tiles.dart';
import 'slot_detail_page.dart';

class BookingGridPage extends StatefulWidget {
  final String sport;
  final String loggedInUser;

  const BookingGridPage({
    super.key,
    required this.sport,
    required this.loggedInUser,
  });

  @override
  State<BookingGridPage> createState() => _BookingGridPageState();
}

class _BookingGridPageState extends State<BookingGridPage> {
  final List<Slot> slots = List.generate(
    10,
    (i) => Slot(
      time: '${(i + 6) % 12 == 0 ? 12 : (i + 6) % 12}:00 ${i + 6 < 12 ? 'AM' : 'PM'}',
      capacity: 10,
      players: [
        if (i % 3 == 0) ...['Aryan', 'Riya', 'Dev'],
        if (i % 3 == 1) ...['Sam', 'Priya', 'Kiran', 'Neha', 'Adi', 'Mia', 'Leo'],
        if (i % 4 == 0) ...['Jake', 'Tom'],
      ],
    ),
  );

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Open', 'Filling', 'Full'];

  List<Slot> get filteredSlots {
    if (_selectedFilter == 'All') return slots;
    if (_selectedFilter == 'Full') return slots.where((s) => s.isFull).toList();
    if (_selectedFilter == 'Open') return slots.where((s) => s.status == 'green').toList();
    if (_selectedFilter == 'Filling') {
      return slots.where((s) => s.status == 'yellow' || s.status == 'orange').toList();
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.sport,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Select a time slot',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Legend
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _legend(const Color(0xFF43A047), 'Open'),
                    const SizedBox(width: 12),
                    _legend(const Color(0xFFFFD600), 'Filling'),
                    const SizedBox(width: 12),
                    _legend(const Color(0xFFFF6B35), 'Almost'),
                    const SizedBox(width: 12),
                    _legend(const Color(0xFFE53935), 'Full'),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Filters
              SizedBox(
                height: 36,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final selected = _selectedFilter == _filters[i];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = _filters[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF00D4FF)
                              : Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF00D4FF)
                                : Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          _filters[i],
                          style: TextStyle(
                            color: selected ? const Color(0xFF0F0F1A) : Colors.white60,
                            fontSize: 12,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),

              // Grid
              Expanded(
                child: filteredSlots.isEmpty
                    ? Center(
                        child: Text(
                          'No slots available',
                          style: TextStyle(color: Colors.white.withOpacity(0.3)),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: filteredSlots.length,
                        itemBuilder: (_, index) {
                          return SlotTile(
                            slot: filteredSlots[index],
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => SlotDetailPage(
                                    slot: filteredSlots[index],
                                    loggedInUser: widget.loggedInUser,
                                  ),
                                  transitionsBuilder: (_, anim, __, child) =>
                                      FadeTransition(opacity: anim, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                ),
                              );
                              setState(() {});
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
        ),
      ],
    );
  }
}
