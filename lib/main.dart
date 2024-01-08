
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/firebase/FirebaseService.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();


  final fbService =  FirebaseService();
  await fbService.initialise();

  runApp(const MyApp());
}
