// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'ChildFoodSelectionWidget.dart';

class ChildFoodSelectionWidgetStateful extends StatefulWidget {
  final String childId;
  const ChildFoodSelectionWidgetStateful({super.key, required this.childId});

  @override
  State<ChildFoodSelectionWidgetStateful> createState() => _MyAppState();
}

class _MyAppState extends State<ChildFoodSelectionWidgetStateful>
    with WidgetsBindingObserver {
  String _key = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _key = DateTime.now().millisecondsSinceEpoch.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChildFoodSelectionWidget(childId: widget.childId, key: Key(_key));
  }
}
