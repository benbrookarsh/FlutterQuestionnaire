import 'enums/answer_type_enum.dart';


class Question {
  final int id;
  final String question;
  final AnswerTypeEnum answerType;
  final List<String> options;

  Question({
    required this.id,
    required this.question,
    required this.answerType,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      answerType: _parseAnswerType(json['answerType']),
      options: json['options'] != null ? List<String>.from(json['options']) : [],
    );
  }

  static AnswerTypeEnum _parseAnswerType(int value) {
    switch (value) {
      case 0:
        return AnswerTypeEnum.string;
      case 1:
        return AnswerTypeEnum.multipleChoice;
      case 2:
        return AnswerTypeEnum.multipleChoiceOptional;
      default:
        throw Exception('Invalid AnswerTypeEnum value: $value');
    }
  }
}
