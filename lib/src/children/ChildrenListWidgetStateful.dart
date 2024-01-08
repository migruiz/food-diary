// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'ChildrenListWidget.dart';

class ChildrenListWidgetStateful extends StatefulWidget {
  const ChildrenListWidgetStateful({Key? key}) : super(key: key);





  

  @override
  State<ChildrenListWidgetStateful> createState() => _MyAppState();
}

class _MyAppState extends State<ChildrenListWidgetStateful>  with WidgetsBindingObserver{

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state==AppLifecycleState.resumed){
      setState(() {
        
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return const ChildrenListWidget();
  }
}