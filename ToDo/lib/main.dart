import 'package:ToDo/data/data_store/todo_store.dart';
import 'package:ToDo/presentation/views/todo_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoView(),
    );
  }
}
