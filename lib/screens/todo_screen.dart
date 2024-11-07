import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todo_expanded_widget.dart';
import 'package:todo_app/widgets/todo_text_field.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.withOpacity(0.5),
        title: const Text('Todo App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            TodoTextField(titleController: titleController, descriptionController: descriptionController),
            const SizedBox(height: 15),
            const TodoExpandedWidget(),
          ],
        ),
      ),
    );
  }
}


