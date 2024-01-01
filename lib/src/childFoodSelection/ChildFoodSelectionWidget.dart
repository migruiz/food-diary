// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/childFoodSelection/FoodListItem.dart';

import '../childFoodConfirmation/ChildFoodConfirmationDialog.dart';
import 'ChildFoodSelectionCubit.dart';
import 'ChildFoodSelectionState.dart';

/// Displays a list of SampleItems.
class ChildFoodSelectionWidget extends StatelessWidget {
  final String childId;
  const ChildFoodSelectionWidget({super.key, required this.childId});

  Future<int?> _showConfirmFood(BuildContext context,
      {required String childName,
      required childPhotoUrl,
      required FoodListItem food}) async {
    final confirmResult = await showDialog<int?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ChildFoodConfirmationDialog(
            childName: childName, childPhotoUrl: childPhotoUrl, food: food);
      },
    );
    return confirmResult;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ChildFoodSelectionCubit()..load(childId: childId),
        child: BlocBuilder<ChildFoodSelectionCubit, ChildFoodSelectionState>(
            builder: (context, state) {
          final bloc = BlocProvider.of<ChildFoodSelectionCubit>(context);
          switch (state) {
            case LoadingChildFoodSelectionState():
              {
                return const Scaffold(body: Text("Loading..."));
              }
            case LoadedChildFoodSelectionState():
              {
                return Scaffold(
                    appBar: AppBar(
                        title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(state.childPhotoUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(state.childName),
                        ),
                      ],
                    )),
                    body: ListView.builder(
                      restorationId: 'foodsItemListView',
                      itemCount: state.foods.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = state.foods[index];

                        return ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(
                                    item.lastEatenDescription,
                                    style: item.alarmed
                                        ? const TextStyle(color: Colors.red)
                                        : null,
                                  )
                                ]),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.photoUrl),
                            ),
                            onTap: () async {
                              final daysDelta = await _showConfirmFood(context,
                                  childPhotoUrl: state.childPhotoUrl,
                                  childName: state.childName,
                                  food: item);
                              if (daysDelta != null) {
                                bloc.confirmFoodEaten(
                                    childId: childId,
                                    foodId: item.id,
                                    daysDelta: daysDelta);
                              }
                            });
                      },
                    ));
              }
            default:
              throw Exception(state);
          }
        }));
  }
}
