// ignore_for_file: file_names

class ChildFoodConfirmationState {
  final DaySelected daySelected;
  ChildFoodConfirmationState({required this.daySelected});
}

class DaySelected {
  final int dayDelta;
  final String description;
  static List<DaySelected> options = [
    DaySelected(dayDelta: 0, description: "Now"),
    DaySelected(dayDelta: -1, description: "Yesterday"),
    ...[-2, -3, -4, -5, -6, -7, -8, -9, -10]
        .map((e) => DaySelected(dayDelta: e, description: "$e days ago"))
  ];

  DaySelected({required this.dayDelta, required this.description});
}
