import 'package:flutter/material.dart';

void showToast(BuildContext context, String text,Color color) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: color,
      content:  Text(text),
      duration: const Duration(seconds: 1),
    ),
  );
}