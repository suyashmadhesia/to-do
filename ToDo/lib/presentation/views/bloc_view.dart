import 'package:ToDo/blocs/todo_bloc.dart';
import 'package:ToDo/blocs/todo_state.dart';

import 'package:ToDo/presentation/views/todo_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBlocBuilder extends StatefulWidget {
  @override
  _TodoBlocBuilderState createState() => _TodoBlocBuilderState();
}

class _TodoBlocBuilderState extends State<TodoBlocBuilder>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(listAnimation.value);
    // ignore: close_sinks
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is LoadingTodoState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ShowTodoState) {
          return TodoList(todoBloc, state);
        } else if (state is NoTodoState) {
          return Center(
            child: Text(
              'Hurray ! no todo !!',
              style: TextStyle(color: Colors.redAccent[100], fontSize: 14),
            ),
          );
        }
        return Center(
          child: Text('Unknown Error Occurred !!'),
        );
      },
    );
  }
}
