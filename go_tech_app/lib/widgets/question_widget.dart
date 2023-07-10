import 'package:flutter/material.dart';

import '../models/enums/answer_type_enum.dart';
import '../models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<String> onAnswerChanged;

  QuestionWidget({
    required this.question,
    required this.onAnswerChanged,
    Key? key,
  }) : super(key: key);

  @override
  QuestionWidgetState createState() => QuestionWidgetState();

  void reset() {
    print('RESET DAM');
  }
}

class QuestionWidgetState extends State<QuestionWidget> {
  String? answer;

  TextEditingController answerController = TextEditingController();

  void reset() {
    setState(() {
      answer = null;
      answerController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question: ${widget.question.question}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            if (widget.question.answerType == AnswerTypeEnum.string)
              TextField(
                onChanged: (value) => widget.onAnswerChanged(value),
                controller: answerController,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
              ),
            if (widget.question.answerType == AnswerTypeEnum.multipleChoice)
              Column(
                children: widget.question.options.map((option) {
                  return RadioListTile(
                    title: Text(option),
                    value: option,
                    groupValue: answer,
                    onChanged: (value) {
                      setState(() {
                        print('RADIO BUTTON ANSWER $value');
                        answer = value.toString();
                        print('RADIO ANSWER $answer');
                        widget.onAnswerChanged(value.toString());
                        print('ANSWER SET $answer');
                      });
                    },
                  );
                }).toList(),
              ),
            if (widget.question.answerType == AnswerTypeEnum.multipleChoiceOptional)
              Column(
                children: [
                  ...widget.question.options.map((option) {
                    return RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: answer,
                      onChanged: (value) {
                        setState(() {
                          answer = value.toString();
                          widget.onAnswerChanged(value.toString());
                        });
                      },
                    );
                  }).toList(),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) => widget.onAnswerChanged(value),
                    decoration: InputDecoration(
                      labelText: 'Other',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
