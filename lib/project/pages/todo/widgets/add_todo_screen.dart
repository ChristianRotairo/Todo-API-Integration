import 'package:flutter/material.dart';
import '../../../network/api.dart';


class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
// controller
final  TextEditingController _todoController =  TextEditingController();
final  TodoService _todoService = TodoService();

@override
void dispose(){
  _todoController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Add Todo'),),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextField(
            controller: _todoController,
          decoration: const InputDecoration(
            hintText: 'Add todo'
          ),
          ),
        ),
      ),


      // button to save data

      floatingActionButton: FloatingActionButton(onPressed: () async{
        final todoName = _todoController.text.trim();
        if(todoName.isNotEmpty){
          try{
            final newTodo = await _todoService.createTodo(todoName);
            _todoController.clear();
            Navigator.pop(context, newTodo);
          }catch(e){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
            )
            );
          }
        }
      },
      child: const Icon(Icons.save),),
    );
  }
}








