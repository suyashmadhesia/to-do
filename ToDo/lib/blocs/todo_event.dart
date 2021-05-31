import 'package:ToDo/data/models/todo.dart';
import 'package:equatable/equatable.dart';

class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  final ToDo todo;
  CreateTodoEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

class ShowLoadingScreenEvent extends TodoEvent {}

class FetchTodoEvent extends TodoEvent {}

class MarkDoneTodoEvent extends TodoEvent {
  final ToDo todo;
  MarkDoneTodoEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

// Implement deleting of todo from db
class DeleteTodoEvent extends TodoEvent {}
