import 'package:flutter/material.dart';
import 'package:new_todo/project/pages/todo/widgets/get_todo.dart';

import 'widgets/add_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: const TodoList(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(
          context, MaterialPageRoute
          (builder: (context) => const AddTodoScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
