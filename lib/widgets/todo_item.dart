import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/widgets/showToast.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function onToDoChanged;
  final Function onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
          todo.isDone ? showToast(context, "Completed Task", blueColor) : null;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: todo.isDone ? Colors.blue : blueColor,
        ),
        title: Text(
          todo.todoText!,
          style: const TextStyle(
            fontSize: 16,
            color: blackColor,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id);
              showToast(context, "Task deleted", redColor);
            },
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('onDeleteItem', onDeleteItem));
  }
}
