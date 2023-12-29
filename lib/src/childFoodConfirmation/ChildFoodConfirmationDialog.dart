// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_diary/src/childFoodConfirmation/ChildFoodSelectionState.dart';

import '../childFoodSelection/FoodListItem.dart';

class ChildFoodConfirmationDialog extends StatelessWidget {
  final String childName;
  final String childPhotoUrl;
  final FoodListItem food;

  const ChildFoodConfirmationDialog(
      {super.key,
      required this.childName,
      required this.childPhotoUrl,
      required this.food});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(childPhotoUrl),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(food.photoUrl),
                  ),
                ),
                DropdownButton(
                    value: 0,
                    elevation: 16,
                    onChanged: (int? value) {},
                    items: DaySelected.options
                        .map((e) => DropdownMenuItem(
                            value: e.dayDelta, child: Text(e.description)))
                        .toList())
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('$childName just had ${food.name}'),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('YES'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text('NO'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}