import 'dart:math';

import 'package:ToDo/blocs/todo_bloc.dart';
import 'package:ToDo/blocs/todo_event.dart';
// import 'package:ToDo/blocs/todo_state.dart';
import 'package:ToDo/data/models/todo.dart';
import 'package:ToDo/presentation/components/add_button.dart';
import 'package:ToDo/presentation/components/text_field.dart';
import 'package:ToDo/presentation/views/bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation heading;
  Animation button;
  Animation refresh;
  AnimationController refreshController;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    refreshController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    heading = Tween(begin: 0.0, end: 46.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.20, 0.40, curve: Curves.easeOut)));
    button = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.75, 1.0, curve: Curves.easeOut)));
    refresh = Tween(begin: 0.0, end: 2 * pi).animate(refreshController);
    super.initState();
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    refreshController.dispose();
  }

  String tid;
  String todoText;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(ShowLoadingScreenEvent());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 28.0),
            child: IconButton(
              onPressed: () {
                todoBloc.add(ShowLoadingScreenEvent());
                refreshController.isCompleted
                    ? refreshController.reverse()
                    : refreshController.forward();
              },
              icon: AnimatedBuilder(
                animation: refreshController,
                builder: (context, child) => Transform.rotate(
                  angle: refresh.value,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.grey[900],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'To-Do',
            style: TextStyle(
              fontSize: heading.value,
            ),
          ),
        ),
      ),
      floatingActionButton: Transform.scale(
        scale: button.value,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            addTodoFunction(context, todoBloc);
          },
          backgroundColor: Colors.amber,
          elevation: 5,
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: TodoBlocBuilder(),
      ),
    );
  }

  addTodoFunction(BuildContext parentContext, TodoBloc todoBloc) {
    return showDialog(
      context: parentContext,
      child: SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        titlePadding: EdgeInsets.all(8.0),
        contentPadding: EdgeInsets.all(8.0),
        backgroundColor: Colors.grey[800],
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Todo',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 14,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField(
              textAlignment: TextAlign.start,
              hintText: 'Enter Todo ...',
              onChanged: (value) {
                todoText = value;
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SubmitButton(
              onPressed: () {
                if (todoText != null) {
                  if (todoText.isNotEmpty) {
                    tid = Uuid().v4();
                    ToDo todo = ToDo(todo: todoText, isCompleted: 0, tid: tid);
                    todoBloc.add(CreateTodoEvent(todo));
                    Navigator.of(context).pop();
                    todoBloc.add(ShowLoadingScreenEvent());
                    todoText = '';
                  } else {
                    SnackBar snackBar = SnackBar(
                      duration: Duration(milliseconds: 2500),
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Enable to add empty Todo !!',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    Navigator.of(context).pop();
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                } else {
                  SnackBar snackBar = SnackBar(
                    duration: Duration(milliseconds: 2500),
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'Enable to add empty Todo !!',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                  Navigator.of(context).pop();
                  scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
              buttonColor: Colors.amber,
              buttonName: 'Add Todo',
            ),
          ),
        ],
      ),
    );
  }
}
