// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChildFoodSelectionState.dart';

class ChildFoodConfirmationCubit extends Cubit<ChildFoodConfirmationState> {
  ChildFoodConfirmationCubit() : super(ChildFoodConfirmationState(daySelected: DaySelected.options[0]));


  void changeDay({required int dayDelta}) async {
    final daySelected = DaySelected.options.firstWhere((element) => element.dayDelta==dayDelta);
    emit(ChildFoodConfirmationState(daySelected:daySelected));
  }
}
