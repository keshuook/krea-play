class Slot {
  final String time;
  final int capacity;
  final List<String> players;

  Slot({
    required this.time,
    required this.capacity,
    required this.players,
  });

  bool get isFull => players.length >= capacity;

  String get status {
    if (players.length <= 5) return 'green';
    if (!isFull) return 'yellow';
    return 'red';
  }
}
