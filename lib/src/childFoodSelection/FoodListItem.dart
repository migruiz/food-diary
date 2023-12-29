// ignore_for_file: file_names

class FoodListItem {
  final String id;
  final String name;
  final String photoUrl;
  final DateTime lastEaten;
  final int daysAfterAlarm;

  int get daysSinceEaten{
    return DateTime.now().difference(lastEaten).inDays;
  }
  String get lastEatenDescription{
    final now = DateTime.now();
    final lastEatenStartOfDay = DateTime(lastEaten.year, lastEaten.month, lastEaten.day);
    final secondsDifference = now.difference(lastEatenStartOfDay).inSeconds;
    final daysElapsed = secondsDifference ~/ (24 * 60 * 60);
    switch (daysElapsed) {
      case 0: return "Today";
      case 1: return "Yesterday";
      default: return "$daysElapsed days ago";
    }
  }

  FoodListItem( {required this.id, required this.name, required this.photoUrl, required this.lastEaten, required this.daysAfterAlarm});

}