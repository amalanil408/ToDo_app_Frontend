part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

final class TodoInitial extends TodoState {}

class TodoLoading extends TodoState{}

class TodoLoaded extends TodoState {
  final List<Todo> todo;
  TodoLoaded(this.todo);
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}