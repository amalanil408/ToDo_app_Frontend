import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/BLoC/todo_bloc.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/widgets/delete_alert.dart';
import 'package:todo_app/widgets/edit_todo.dart';

class TodoExpandedWidget extends StatelessWidget {
  const TodoExpandedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todo.length,
              itemBuilder: (context, index) {
                final todo = state.todo[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: todo.isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        final updatedTodo = Todo(
                          id: todo.id,
                          title: todo.title,
                          description: todo.description,
                          isCompleted: value!,
                        );
                        BlocProvider.of<TodoBloc>(context).add(UpdateTodo(updatedTodo));
                      },
                      activeColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => EditTodoDialog(
                                todo: todo,
                                onConfirm: (updatedTitle, updatedDescription) {
                                  final updatedTodo = Todo(
                                    id: todo.id,
                                    title: updatedTitle,
                                    description: updatedDescription,
                                    isCompleted: todo.isCompleted,
                                  );
                                  BlocProvider.of<TodoBloc>(context).add(UpdateTodo(updatedTodo));
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            showDeleteAlertDialog(context, todo.id);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is TodoError) {
            return const Center(child: Text("Failed to load todos"));
          }
          return const Center(child: Text("No Todos Available"));
        },
      ),
    );
  }
}