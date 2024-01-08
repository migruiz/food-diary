// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/childFoodSelection/ChildFoodSelectionWidget.dart';
import 'package:food_diary/src/children/ChildrenCubit.dart';
import 'package:food_diary/src/children/ChildrenListState.dart';

/// Displays a list of SampleItems.
class ChildrenListWidget extends StatelessWidget {
  const ChildrenListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChildrenCubit()..load(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Children')
          ),
          body: BlocBuilder<ChildrenCubit, ChildrenListState>(
            builder: (context, state) {
              if (state is LoadingChildrenListState) {
                return const Text('Loading...');
              } else if (state is LoadedChildrenListState) {
                return ListView.builder(
                  restorationId: 'sampleItemListView',
                  itemCount: state.children.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.children[index];

                    return ListTile(
                        title: Text(item.name),
                        leading: ClipOval(
                            child: CachedNetworkImage(
                          width: 56.00,
                          height: 56.00,
                          fit: BoxFit.cover,
                          imageUrl: item.photoUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                        onTap: () async{


                      await Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) => ChildFoodSelectionWidget(childId: item.id)));
                                    


                        });
                  },
                );
              }
              return Container();
            },
          )),
    );
  }
}
