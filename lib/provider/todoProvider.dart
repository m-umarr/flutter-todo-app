
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/todo.dart';

class ToDoListNotifier extends ChangeNotifier {
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  Future<void> loadToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString('todos');
    if (todosJson != null) {
      _todos = ToDo.decodeJsonList(todosJson);
      notifyListeners();
    }
  }

  Future<void> saveToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = ToDo.encodeJsonList(_todos);
    await prefs.setString('todos', todosJson);
  }

  void addToDoItem(String toDo) {
    _todos.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
      isDone: false,
    ));
    saveToDoList();
    notifyListeners();
  }

  void deleteToDoItem(String id) {
    _todos.removeWhere((item) => item.id == id);
    saveToDoList();
    notifyListeners();
  }

  void handleToDoChange(ToDo todo) {
    todo.isDone = !todo.isDone;
    saveToDoList();
    notifyListeners();
  }
}
