import 'dart:convert';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [];
  }
  static String encodeJsonList(List<ToDo> todos) {
    return jsonEncode(todos.map((todo) => todo.toJson()).toList());
  }

  static List<ToDo> decodeJsonList(String jsonList) {
    final Iterable decoded = jsonDecode(jsonList);
    return decoded.map((item) => ToDo.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
    };
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      isDone: json['isDone'],
    );
  }
}