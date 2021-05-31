import 'package:ToDo/data/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoStore {
  SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  ToDoStore() {
    this.init();
  }

  setTodo(ToDo todo) async {
    if (prefs == null) {
      await init();
    }
    prefs.setStringList(todo.tid, [todo.todo, todo.isCompleted.toString()]);
  }

  Future<Map<String, dynamic>> getTodo() async {
    if (prefs == null) {
      await init();
    }
    Map<String, dynamic> data = Map<String, dynamic>();
    Set keys = prefs.getKeys();
    for (String key in keys) {
      data[key] = prefs.getStringList(key);
    }
    return data;
  }
}
