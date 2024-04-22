import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/provider/todoProvider.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoListNotifier(),
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(primary: Colors.blue, seedColor: Colors.blue,),
      ),
      home: HomeScreen(),
    );
  }
}
