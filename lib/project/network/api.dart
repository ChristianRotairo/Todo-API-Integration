import 'package:dio/dio.dart';

// *Model
class Todo {
  final String todo;
  final int? id;

  Todo({required this.todo, this.id});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      todo: json['todo'] as String? ?? '', // Use empty string as fallback
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {'todo': todo};
}

// *API Request Methods
class TodoService {
  final Dio _dio;
  static const String _baseURL = 'http://10.0.2.2:8000/api/travelhistory';

  TodoService() : _dio = Dio() {
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

// *POST
  Future<Todo> createTodo(String todo) async {
    try {
      final response = await _dio.post(_baseURL, data: {'todo': todo});
      return Todo.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create todo: $e');
    }
  }

//*GET
  Future<List<Todo>> getTodos() async {
    try {
      final response = await _dio.get(_baseURL);
      return (response.data as List)
          .map((todo) => Todo.fromJson(todo))
          .toList();
    } catch (e) {
      throw Exception('Failed to get todos: $e');
    }
  }

//*UPDATE
  Future<Todo> updateTodo(int id, String todo) async {
    try {
      final response = await _dio.put('$_baseURL/$id', data: {'todo': todo});
      return Todo.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

//* DELETE
  Future<void> deleteTodo(int id) async {
    try {
      await _dio.delete('$_baseURL/$id');
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
