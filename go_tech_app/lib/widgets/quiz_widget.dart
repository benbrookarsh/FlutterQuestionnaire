import 'package:flutter/material.dart';
import '../blocs/answer_bloc.dart';
import '../blocs/question_block.dart';
import '../models/question.dart';
import 'question_widget.dart';

class QuizWidget extends StatefulWidget {
  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late QuestionBloc _questionBloc;
  late AnswerBloc _answerBloc;

  List<GlobalKey<QuestionWidgetState>> questionWidgetKeys = [];

  Future<void> _showDialog(String title, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(content)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok then'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _questionBloc = QuestionBloc();
    _answerBloc = AnswerBloc();
    _questionBloc.fetchQuestions();
  }

  @override
  void dispose() {
    _questionBloc.dispose();
    _answerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: StreamBuilder<List<Question>>(
        stream: _questionBloc.questionsStream,
        builder: (context, snapshot) {
          List<Question> questions = [];
          if (snapshot.hasData) {
            questions = snapshot.data!;
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final questionWidgetKey = GlobalKey<QuestionWidgetState>();
                questionWidgetKeys.add(questionWidgetKey);
                final question = questions[index];
                var questionWidget = QuestionWidget(
                  key: questionWidgetKey,
                  question: question,
                  onAnswerChanged: (answer) {
                    _answerBloc.registerAnswer(question.id, answer);
                  },
                );
                return questionWidget;
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // CHECK THAT ALL QUESTIONS ARE ANSWERED
          if (_answerBloc.answers.length == _questionBloc.questionsLength) {
            var success = await _answerBloc.sendAnswers();
            if (success) {
              _showDialog('Answers submitted successfully',
                  'Thank you for completing the questionnaire!');
              for (var key in questionWidgetKeys) {
                key.currentState?.reset();
              }
            } else {
              _showDialog('Failed submitting answers', 'Please try again');
            }
            return;
          }
          _showDialog('Please complete all the questions',
              'All questions need to be answered before sending');
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
