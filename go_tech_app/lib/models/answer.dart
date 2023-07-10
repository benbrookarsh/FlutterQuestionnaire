class Answer {
  final int questionId;
  final String answer;

  Answer({
    required this.questionId,
    required this.answer
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer
    };
  }
}
