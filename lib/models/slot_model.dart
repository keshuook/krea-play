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

  double get fillRatio => players.length / capacity;

  String get status {
    if (players.length <= 3) return 'green';
    if (players.length <= 7) return 'yellow';
    if (!isFull) return 'orange';
    return 'red';
  }

  String get statusLabel {
    if (isFull) return 'Full';
    if (players.length <= 3) return 'Open';
    if (players.length <= 7) return 'Filling';
    return 'Almost Full';
  }
}
