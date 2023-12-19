import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_diary/src/children/ChildrenCubit.dart';
import 'package:food_diary/src/children/ChildrenListState.dart';

/// Displays a list of SampleItems.
class ChildrenListWidget extends StatelessWidget {
  static const List<String> items = ["one", "two", "3"];

  const ChildrenListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChildrenCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Children'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
          body: BlocBuilder<ChildrenCubit, ChildrenListState>(
            builder: (context, state) {
              if (state is LoadingChildrenListState) {
                return const Text('Loading...');
              } else if (state is LoadedChildrenListState) {
                return ListView.builder(
                  restorationId: 'sampleItemListView',
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];

                    return ListTile(
                        title: Text('$item'),
                        leading: const CircleAvatar(
                          foregroundImage:
                              AssetImage('assets/images/flutter_logo.png'),
                        ),
                        onTap: () {});
                  },
                );
              }
              return Container();
            },
          )),
    );
  }
}
