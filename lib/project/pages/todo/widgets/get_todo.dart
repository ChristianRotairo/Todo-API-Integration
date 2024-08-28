import 'package:flutter/material.dart';

import '../../../network/api.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TodoService _todoService = TodoService();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

// GET fuction
  Future<void> _fetchTodos() async {
    try {
      final todos = await _todoService.getTodos();
      setState(() {
        _todos = todos;
      });
    } catch (e) {
      print(e);
    }
  }

  // Delete Function
  Future<void> _deleteTodo(int id) async {
    try {
      await _todoService.deleteTodo(id);
      _fetchTodos();
    } catch (e) {
      print(e);
    }
  }

  void _showEditDialog(int id, String currentTodo) {
    final todoTextController = TextEditingController(text: currentTodo);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Todo'),
            content: TextField(
              controller: todoTextController,
              decoration: const InputDecoration(
                hintText: "Edit Todo",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final editedTodo = todoTextController.text.trim();
                  if (editedTodo.isNotEmpty) {
                    await _todoService.updateTodo(id, editedTodo);
                    _fetchTodos();
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a todo text'),
                      ),
                    );
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              final todo = _todos[index];
              return ListTile(
                title: Text(todo.todo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => _showEditDialog(todo.id!, todo.todo),
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => _deleteTodo(todo.id!),
                        icon: const Icon(Icons.delete))
                  ],
                ),
              );
            }));
  }
}
