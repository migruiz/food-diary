// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/childFoodSelection/FoodListItem.dart';

import 'ChildFoodSelectionCubit.dart';
import 'ChildFoodSelectionState.dart';

/// Displays a list of SampleItems.
class ChildFoodSelectionWidget extends StatelessWidget {
  final String childId;
  const ChildFoodSelectionWidget({super.key, required this.childId});

  Future<bool> _showConfirmFood(BuildContext context,
      {required String childName,
      required childPhotoUrl,
      required FoodListItem food}) async {
    final confirmResult = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(food.photoUrl),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('$childName just had ${food.name}'),
                ),
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
      },
    );
    return confirmResult == true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ChildFoodSelectionCubit()..load(childId: childId),
        child: BlocBuilder<ChildFoodSelectionCubit, ChildFoodSelectionState>(
            builder: (context, state) {
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
                                  Text(item.name),
                                  Text(
                                      'Last Eaten: ${item.daysSinceEaten} days ago'),
                                ]),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.photoUrl),
                            ),
                            onTap: () async {
                              final result = await _showConfirmFood(context,
                                  childPhotoUrl: state.childPhotoUrl,
                                  childName: state.childName,
                                  food: item);
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
