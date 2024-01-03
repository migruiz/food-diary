// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/children/ChildInfoListItem.dart';
import 'package:food_diary/src/children/ChildrenListState.dart';

class ChildrenCubit extends Cubit<ChildrenListState> {
  ChildrenCubit() : super(LoadingChildrenListState());

  void load() async {
    final db = FirebaseFirestore.instance;
    final children = await db
        .collection("families")
        .doc("ruizblanco")
        .collection("children")
        .get();
    final childrenInfoList = children.docs
        .map((d) => ( id: d.id, data: d.data()))
        .map((e) => ChildInfoListItem(name: e.data["name"], photoUrl: e.data["photoUrl"], id: e.id))
        .toList();
    emit(LoadedChildrenListState(children: childrenInfoList));
  }
}
