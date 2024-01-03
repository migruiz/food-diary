// ignore_for_file: file_names

class FoodListItem {
  final String id;
  final String name;
  final String photoUrl;
  final DateTime lastEaten;
  final int daysAfterAlarm;
  late bool alarmed;
  late String lastEatenDescription;

  void setCalculatedFields() {
    final daysSinceEaten = getDaysSinceEaten();
    alarmed = daysSinceEaten >= daysAfterAlarm;
    switch (daysSinceEaten) {
      case 0:
        lastEatenDescription = "Today";
        break;
      case 1:
        lastEatenDescription = "Yesterday";
        break;
      default:
        lastEatenDescription = "$daysSinceEaten days ago";
        break;
    }
  }

  int getDaysSinceEaten() {
    final now = DateTime.now();
    final lastEatenStartOfDay =
        DateTime(lastEaten.year, lastEaten.month, lastEaten.day);
    final secondsDifference = now.difference(lastEatenStartOfDay).inSeconds;
    final daysElapsed = secondsDifference ~/ (24 * 60 * 60);
    return daysElapsed;
  }

  FoodListItem(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.lastEaten,
      required this.daysAfterAlarm});
}
