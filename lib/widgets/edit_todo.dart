
import 'package:flutter/material.dart';
import 'package:todo_app/models/models.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;
  final Function(String title, String description) onConfirm;

  const EditTodoDialog({
    Key? key,
    required this.todo,
    required this.onConfirm,
  }) : super(key: key);

  @override
  EditTodoDialogState createState() => EditTodoDialogState();
}

class EditTodoDialogState extends State<EditTodoDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Enter Todo Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Enter Todo Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(titleController.text, descriptionController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
