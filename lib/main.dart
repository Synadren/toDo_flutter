import 'package:flutter/material.dart';
import 'home_page.dart';
import 'todo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    ToDoPage.tag: (context) => ToDoPage(),
  };
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super-poney',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: routes
    );
  }
}
