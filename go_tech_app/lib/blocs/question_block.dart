import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/question.dart';

class QuestionBloc {
  final _questionsController = StreamController<List<Question>>.broadcast();
  Stream<List<Question>> get questionsStream => _questionsController.stream;

  List<Question> _questions = [];

  int get questionsLength => _questions.length;

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/questions'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Question> questions = jsonData
            .map((data) => Question.fromJson(data))
            .toList();
        _questions = questions;
        _questionsController.sink.add(questions);
      } else {
        throw Exception('Failed to fetch questions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void dispose() {
    _questionsController.close();
  }
}
