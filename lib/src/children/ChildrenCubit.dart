import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/children/ChildrenListState.dart';

class ChildrenCubit extends Cubit<ChildrenListState> {
  ChildrenCubit() : super(LoadingChildrenListState());

  void load() async {
    final db = FirebaseFirestore.instance;
    final families = await db.collection("families").get();
    emit(LoadedChildrenListState(children: []));
  }
}
