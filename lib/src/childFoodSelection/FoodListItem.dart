// ignore_for_file: file_names

class FoodListItem {
  final String id;
  final String name;
  final String photoUrl;
  final DateTime lastEaten;
  final int daysAfterAlarm;
  late bool alarmed;
  late String lastEatenDescription;
  late String eatAgainDescription;

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
    final eatAgainInDays = daysAfterAlarm - daysSinceEaten;
    if (eatAgainInDays case 0) {
      eatAgainDescription = "Eat Today";
    } else if (eatAgainInDays case 1) {
      eatAgainDescription = "Eat Tomorrow";
    } else if (eatAgainInDays > 1) {
      eatAgainDescription = "Eat in $eatAgainInDays days";
    } else if (eatAgainInDays case -1) {
      eatAgainDescription = "Should have eaten Yesterday ";
    } else if (eatAgainInDays < -1) {
      eatAgainDescription =
          "Should have eaten ${-1 * eatAgainInDays} days ago ";
    } else {
      eatAgainDescription = eatAgainInDays.toString();
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
