import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_app/models/models.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final String baseUrl = 'http://192.168.29.231:3000/api/todos';

  Future<List<Todo>> getAllTodos() async{
    final Response response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode == 200){
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Todo.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }

  Future<void> addTodos(String title , String description)async{
   await http.post(Uri.parse(baseUrl),
   headers: {"Content-Type" : "application/json"},
   body: json.encode({"title" : title , "description" : description})
   );
  }

  Future<void> updateTodo(Todo todo) async {
    final url = '$baseUrl/${todo.id}';
    await http.put(Uri.parse(url),
    headers: {"Content-Type" : "application/json"},
    body: json.encode(todo.toJson()),
    );
  }

  Future<void> deleteTodo(String id) async {
    final url = '$baseUrl/$id';
    await http.delete(Uri.parse(url));
  }
}