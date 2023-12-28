import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChildFoodSelectionState.dart';

class ChildFoodSelectionCubit extends Cubit<ChildFoodSelectionState> {
  ChildFoodSelectionCubit() : super(LoadingChildFoodSelectionState());

  void load() async {
    final db = FirebaseFirestore.instance;
  }
}
