import 'package:flutter/material.dart';
import 'package:hello/my_home.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        // primaryColor:kBackgroundColor2,
        // scaffoldBackgroundColor: 
      ),
      home: MyHome(),
        
    );
  }
}