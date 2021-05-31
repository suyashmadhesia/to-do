import 'package:ToDo/blocs/todo_bloc.dart';
import 'package:ToDo/blocs/todo_event.dart';
import 'package:ToDo/data/models/todo.dart';
import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String todoText;
  final bool isCompleted;
  final TodoBloc todoBloc;
  final String tid;

  Tile(this.todoText, this.isCompleted,
      {@required this.todoBloc, @required this.tid});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      title: Text(
        widget.todoText,
        style: TextStyle(
            decoration: widget.isCompleted ? TextDecoration.lineThrough : null,
            color: widget.isCompleted ? Colors.grey : Colors.white,
            fontSize: 16),
      ),
      trailing: Checkbox(
        activeColor: Colors.amberAccent,
        value: widget.isCompleted,
        onChanged: (value) {
          int x;
          if (widget.isCompleted) {
            x = 0;
          } else {
            x = 1;
          }
          ToDo todo =
              ToDo(todo: widget.todoText, tid: widget.tid, isCompleted: x);
          setState(() {
            widget.todoBloc.add(MarkDoneTodoEvent(todo));
          });
        },
      ),
    );
  }
}
