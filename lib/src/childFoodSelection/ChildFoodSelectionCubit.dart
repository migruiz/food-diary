import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/childFoodSelection/FoodListItem.dart';

import 'ChildFoodSelectionState.dart';

class ChildFoodSelectionCubit extends Cubit<ChildFoodSelectionState> {
  ChildFoodSelectionCubit() : super(LoadingChildFoodSelectionState());

  void confirmFoodEaten(
      {required String childId, required String foodId, required int daysDelta}) async {
    final db = FirebaseFirestore.instance;
    final lastEaten = DateTime.now().add(Duration(days: daysDelta));

    await db
        .collection("families")
        .doc("ruizblanco")
        .collection("children")
        .doc(childId)
        .collection("foods")
        .doc(foodId)
        .update({"lastEaten": Timestamp.fromDate(lastEaten)});

    load(childId: childId);
  }

  void load({required String childId}) async {
    final db = FirebaseFirestore.instance;
    final childFuture = db
        .collection("families")
        .doc("ruizblanco")
        .collection("children")
        .doc(childId)
        .get();

    final childFoodsFuture = db
        .collection("families")
        .doc("ruizblanco")
        .collection("children")
        .doc(childId)
        .collection("foods")
        .get();

    final (child, childFoods) = await (childFuture, childFoodsFuture).wait;

    final childData = child.data()!;

    final childFoodsList = childFoods.docs
        .map((f) => (id: f.id, data: f.data()))
        .map((d) => FoodListItem(
            id: d.id,
            name: d.data["name"],
            photoUrl: d.data["photoUrl"],
            lastEaten: DateTime.fromMillisecondsSinceEpoch(
                (d.data["lastEaten"] as Timestamp).millisecondsSinceEpoch)))
        .toList();
        childFoodsList.sort((a, b) => a.name.compareTo(b.name));

    emit(LoadedChildFoodSelectionState(
        childName: childData["name"],
        childPhotoUrl: childData["photoUrl"],
        foods: childFoodsList));
  }
}
