import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_todo_app/provider/todoProvider.dart';

void main() {
  group('ToDoListNotifier Tests', () {
    late ToDoListNotifier toDoListNotifier;
    SharedPreferences.setMockInitialValues({});

    setUp(() {
      toDoListNotifier = ToDoListNotifier();
    });

    test('addToDoItem adds a new ToDo item', () async {
      final initialLength = toDoListNotifier.todos.length;

      toDoListNotifier.addToDoItem('Test ToDo');

      await Future.delayed(const Duration(milliseconds: 100));

      expect(toDoListNotifier.todos.length, initialLength + 1);
      expect(toDoListNotifier.todos.last.todoText, 'Test ToDo');
    });

    test('deleteToDoItem removes the specified ToDo item', () async {
      toDoListNotifier.addToDoItem('Test ToDo');

      await Future.delayed(const Duration(milliseconds: 100));

      final initialLength = toDoListNotifier.todos.length;
      final todoIdToDelete = toDoListNotifier.todos.last.id;
      toDoListNotifier.deleteToDoItem(todoIdToDelete!);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(toDoListNotifier.todos.length, initialLength - 1);
      expect(toDoListNotifier.todos.any((todo) => todo.id == todoIdToDelete), isFalse);
    });
  });
}
