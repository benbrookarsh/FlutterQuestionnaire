import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/answer.dart';

class AnswerBloc {
  final _answersController = StreamController<Map<int, dynamic>>.broadcast();
  Stream<Map<int, dynamic>> get answersStream => _answersController.stream;

  List<Answer> answers = [];

  Future<void> registerAnswer(int questionId, dynamic answer) async {
    var addAnswer = Answer(questionId: questionId, answer: answer);
    var indexIfExists = answers.indexWhere((a) => a.questionId == questionId);
    if(indexIfExists == -1) {
      answers.add(addAnswer);
    } else {
      answers[indexIfExists] = addAnswer;
    }

    print('QUETION ID ${addAnswer.questionId} ANSWER ${addAnswer.answer}');
  }

  Future<bool> sendAnswers() async {

    var asEncoded = jsonEncode(answers);

    final response = await http.post(
      Uri.parse('http://localhost:3000/answers'),
      body: asEncoded,
      headers: {
        'Content-Type': 'application/json'
      },
    );

    switch(response.statusCode) {
      case 200:
      case 201:
        answers = [];
        print('Answers submitted');
        return true;
      default:
        print('Failed to submit answers');
        return false;
    }
  }

  void dispose() {
    _answersController.close();
  }
}
