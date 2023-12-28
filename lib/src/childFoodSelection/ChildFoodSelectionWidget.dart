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
                            title: Text(item.name),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.photoUrl),
                            ),
                            onTap: () async {});
                      },
                    ));
              }
            default:
              throw Exception(state);
          }
        }));
  }
}
