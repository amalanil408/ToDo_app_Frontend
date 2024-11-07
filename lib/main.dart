import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/BLoC/todo_bloc.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:todo_app/service/service.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoService todoService = TodoService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoBloc(todoService)..add(FetchTodo()),
        child: const TodoScreen(),
        ),
    );
  }
}