import 'package:flutter/material.dart';
import 'package:intermittentfasting/ui/IFHome.dart';

void main() => runApp(IFApp());

class IFApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intermittent Fasting Tracker',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: IFHome(),
    );
  }
}
