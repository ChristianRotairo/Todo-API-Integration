import 'package:dio/dio.dart';


class Todo{
  final String todo;
  final int? id ;

  Todo({required this.todo, required this.id});


  factory Todo.fromJson (Map<String, dynamic> json){
    return Todo(
      todo: json['todo'] as String,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'todo': todo,
    };
  }
}

class TodoService{
  final Dio _dio;
  final String _baseURL = 'http://10.0.2.2:8000/api/travelhistory';

  TodoService()
  :_dio = Dio()..interceptors.add(LogInterceptor(requestBody: true, responseBody :true));


// Post method for todos
  Future<Todo> createTodo(String todo) async {
    try {
      final response = await _dio.post(
        _baseURL,
        data: {'todo': todo},
      );
      if (response.statusCode == 201) {
        return Todo.fromJson(response.data);
      } else {
        throw Exception('Failed to create todo: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // GET method 
  Future<List<Todo>> getTodos()async{
    try{
      final response = await _dio.get(_baseURL);
      if(response.statusCode == 200){
        return List<Todo>.from(response.data.map((todo) => Todo.fromJson(todo)));
      }else {
         throw Exception('Failed to get todos: ${response.statusCode} ${response.statusMessage}');
      }
    }catch(e){
      throw Exception("Failed to get todos:$e");
    }
  }


  // update todo
  Future<Todo> updateTodo(int id, String todo) async {
    try{
      final response = await _dio.put(
        "$_baseURL/$id",
        data: {'todo':todo},
      );
      if(response.statusCode == 200){
        return Todo.fromJson(response.data);
      }else {
         throw Exception('Failed to update todo: ${response.statusCode} ${response.statusMessage}');
      }
    }catch(e){
      throw Exception("Failed to update todo:$e");
    }
  }

  // delete todo
  Future<void> deleteTodo(int id) async {
   try{
     final response = await _dio.delete("$_baseURL/$id");
     if(response.statusCode == 204){
       return;
     }else {
        throw Exception('Failed to delete todo: ${response.statusCode} ${response.statusMessage}');
     }
   }catch(e){
     throw Exception("Failed to delete todo:$e");
   }
  }
}