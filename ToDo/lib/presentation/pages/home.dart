import 'package:ToDo/blocs/todo_bloc.dart';
import 'package:ToDo/blocs/todo_event.dart';
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

class _HomePageState extends State<HomePage> {
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
                todoBloc.add(DeleteTodoEvent());
              },
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 24,
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.grey[800],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'To-Do',
            style: TextStyle(
              fontSize: 46,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: BlocTodoBuilder(),
      ),
    );
  }

  addTodoFunction(BuildContext parentContext, TodoBloc todoBloc) {
    return showDialog(
      context: parentContext,
      child: SimpleDialog(
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
              buttonName: 'Add',
            ),
          ),
        ],
      ),
    );
  }
}
