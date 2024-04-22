import 'package:flutter/material.dart';
import 'package:flutter_todo_app/provider/todoProvider.dart';
import 'package:flutter_todo_app/widgets/showToast.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _todoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ToDoListNotifier>(context, listen: false).loadToDoList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrayColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'All ToDos',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ToDoListNotifier>(
                  builder: (context, toDoListProvider, _) {
                    final todos = toDoListProvider.todos;
                    return todos.isEmpty ? const Center(child: Text("ToDo's empty",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))): ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return ToDoItem(
                          todo: todo,
                          onToDoChanged: toDoListProvider.handleToDoChange,
                          onDeleteItem: toDoListProvider.deleteToDoItem,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        onPressed: (){
          showDialog(
            context: context,
            useRootNavigator: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add ToDo'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _todoController,
                    maxLines: 5,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Add a new todo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a todo';
                      }
                      return null;
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) { // Check if the form is valid
                        _addToDoItem(context, _todoController.text);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );

            },
          );
        },
        tooltip: 'Add ToDos',
        child: const Icon(Icons.add,color: whiteColor,),
      ),
    );
  }

  void _addToDoItem(BuildContext context, String toDo) {
    if (toDo.isNotEmpty) {
      final toDoListProvider = Provider.of<ToDoListNotifier>(context, listen: false);
      toDoListProvider.addToDoItem(toDo);
      _todoController.clear();
      Navigator.of(context).pop();
    }
  }
}
