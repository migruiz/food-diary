import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/childFoodSelection/FoodListItem.dart';

import 'ChildFoodSelectionState.dart';

class ChildFoodSelectionCubit extends Cubit<ChildFoodSelectionState> {
  ChildFoodSelectionCubit() : super(LoadingChildFoodSelectionState());

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
        .map((f) => f.data())
        .map((d) => FoodListItem(name: d["name"], photoUrl: d["photoUrl"]))
        .toList();

    emit(LoadedChildFoodSelectionState(
        childName: childData["name"],
        childPhotoUrl: childData["photoUrl"],
        foods: childFoodsList));
  }
}
