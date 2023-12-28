// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChildFoodSelectionCubit.dart';
import 'ChildFoodSelectionState.dart';

/// Displays a list of SampleItems.
class ChildFoodSelectionWidget extends StatelessWidget {
  final String childId;
  const ChildFoodSelectionWidget({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Text(childId);
  }
}
