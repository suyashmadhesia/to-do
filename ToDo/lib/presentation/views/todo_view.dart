import 'package:ToDo/blocs/todo_bloc.dart';
import 'package:ToDo/blocs/todo_state.dart';
import 'package:ToDo/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoBloc(LoadingTodoState()),
      child: HomePage(),
    );
  }
}
