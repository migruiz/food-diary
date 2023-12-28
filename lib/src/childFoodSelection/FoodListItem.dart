// ignore_for_file: file_names

class FoodListItem {
  final String name;
  final String photoUrl;
  final DateTime lastEaten;

  int get daysSinceEaten{
    return DateTime.now().difference(lastEaten).inDays;
  }

  FoodListItem({required this.name, required this.photoUrl, required this.lastEaten});

}