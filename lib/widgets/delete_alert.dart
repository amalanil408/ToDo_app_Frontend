import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/BLoC/todo_bloc.dart';

void showDeleteAlertDialog(BuildContext context , String id){
  showDialog(
    context: context, 
    builder: (ctx) => AlertDialog(
      title: const Text("Delete To-Do"),
      content: const Text("Are you sure to delete the TO-DO"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child:const Text("NO")),
        TextButton(onPressed: (){
          BlocProvider.of<TodoBloc>(context).add(DeleteTodo(id));
          Navigator.pop(context);
        }, child: const Text("Yes"))
      ],
    )
    );
}