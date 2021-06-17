import 'package:ToDo/presentation/components/list_tile.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  final bloc;
  final state;
  TodoList(this.bloc, this.state);
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> with TickerProviderStateMixin {
  AnimationController controller;

  ///For controlling animation of the list content
  Animation listAnimation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    // Opacity goes from 0.0 to 1.0
    listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeInQuad)));
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: listAnimation.value,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.state.data.length,
        itemBuilder: (BuildContext context, int index) {
          String key = widget.state.data.keys.elementAt(index);
          // debugPrint(key);
          // print(state.data);
          bool isChecked;
          if (widget.state.data[key][1] == '0') {
            isChecked = false;
          } else {
            isChecked = true;
          }
          // return Text(state.data[key][0]);
          return Tile(
            widget.state.data[key][0],
            isChecked,
            todoBloc: widget.bloc,
            tid: key,
          );
        },
      ),
    );
  }
}
