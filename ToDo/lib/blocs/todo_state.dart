import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoTodoState extends TodoState {}

class ShowTodoState extends TodoState {
  final data;
  ShowTodoState(this.data);
  @override
  List<Object> get props => [data];
  get store => data;
}

class LoadingTodoState extends TodoState {}

class ErrorLoadingTodo extends TodoState {}
