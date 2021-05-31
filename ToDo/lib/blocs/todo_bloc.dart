import 'package:ToDo/blocs/todo_event.dart';
import 'package:ToDo/blocs/todo_state.dart';
import 'package:ToDo/data/data_store/todo_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(TodoState initialState) : super(initialState);
  ToDoStore store = ToDoStore();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is ShowLoadingScreenEvent) {
      yield LoadingTodoState();
      if (store.prefs == null) {
        await store.init();
      }
      await Future.delayed(Duration(seconds: 1));
      this..add(FetchTodoEvent());
    } else if (event is FetchTodoEvent) {
      final data = await store.getTodo();
      if (data.isNotEmpty) {
        yield ShowTodoState(data);
      } else {
        yield NoTodoState();
      }
    } else if (event is CreateTodoEvent) {
      await store.setTodo(event.todo);
      final data = await store.getTodo();
      yield ShowTodoState(data);
    } else if (event is MarkDoneTodoEvent) {
      await store.setTodo(event.todo);
      final data = await store.getTodo();
      yield ShowTodoState(data);
    } else if (event is DeleteTodoEvent) {
      store.prefs.clear();
      yield LoadingTodoState();
      await Future.delayed(Duration(seconds: 1));
      this..add(FetchTodoEvent());
    } else {
      yield ErrorLoadingTodo();
    }
  }
}
