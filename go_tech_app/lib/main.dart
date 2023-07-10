import 'package:flutter/material.dart';
import 'package:go_tech_app/widgets/quiz_widget.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.deepPurple
    ),
    home: QuizWidget(),
  ));
}
