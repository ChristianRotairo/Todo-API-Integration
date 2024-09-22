// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../network/api.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _todoController = TextEditingController();
  final TodoService _todoService = TodoService();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _todoController,
              decoration: const InputDecoration(
                hintText: 'Enter todo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveTodo,
              child: const Text('Save Todo'),
            ),
          ],
        ),
      ),
    );
  }

// *save todo
  Future<void> saveTodo() async {
    final todoName = _todoController.text.trim();
    if (todoName.isNotEmpty) {
      try {
        final newTodo = await _todoService.createTodo(todoName);
        _todoController.clear();
        Navigator.pop(context, newTodo);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add todo: ${e.toString()}'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a todo'),
      ));
    }
  }
}
