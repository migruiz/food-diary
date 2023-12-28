import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChildFoodSelectionState.dart';

class ChildFoodSelectionCubit extends Cubit<ChildFoodSelectionState> {
  ChildFoodSelectionCubit() : super(LoadingChildFoodSelectionState());

  void load({required String childId}) async {
    final db = FirebaseFirestore.instance;
    final child = await db
        .collection("families")
        .doc("ruizblanco")
        .collection("children")
        .doc(childId)
        .get();
    final childData = child.data()!;
    emit(LoadedChildFoodSelectionState(
        childName: childData["name"],
        childPhotoUrl: childData["photoUrl"],
        foods: []));
  }
}
