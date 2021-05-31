import 'package:ToDo/blocs/todo_bloc.dart';
import 'package:ToDo/blocs/todo_state.dart';
import 'package:ToDo/presentation/components/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocTodoBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is LoadingTodoState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ShowTodoState) {
          //
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.data.length,
            itemBuilder: (BuildContext context, int index) {
              String key = state.data.keys.elementAt(index);
              debugPrint(key);
              print(state.data);
              bool isChecked;
              if (state.data[key][1] == '0') {
                isChecked = false;
              } else {
                isChecked = true;
              }
              // return Text(state.data[key][0]);
              return Tile(
                state.data[key][0],
                isChecked,
                todoBloc: todoBloc,
                tid: key,
              );
            },
          );
        } else if (state is NoTodoState) {
          return Center(
            child: Text(
              'No todo please create one !!',
              style: TextStyle(color: Colors.redAccent, fontSize: 14),
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
