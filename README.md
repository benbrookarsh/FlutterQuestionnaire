# FlutterQuestionnaire
## Thought Process for Data Format

I considered using an enum for the multiple-choice answers to make the HTTP requests more efficient. However, I felt that prioritizing data integrity over optimizing the HTTP request was more important. Using string values for each question's answer makes the data easier to read for the recipients of the answers. They are free to use and manipulate the data as they see fit, without the need to parse enums for matching the answers to actual values.

Taking these considerations into account, I decided to return string values for both radio button and plain text answers to the server. The answer data is presented in a readable format, matching the question ID to its corresponding answer.
JSON Data Format for Answers

### Answers json

```

"answers": [
  [
    {
      "questionId": 1,
      "answer": "C++"
    },
    {
      "questionId": 2,
      "answer": "it's fun"
    },
    {
      "questionId": 3,
      "answer": "Normal"
    }
  ]
]

```

Questions and Answer Types

For questions, I assigned each question an answer type enum to ensure correct UI display in the Flutter app. The enum is defined in the file ```answer_type_enum.dart.``` Based on this enum, the UI can render the QuestionWidget appropriately, including multiple-choice questions with radio buttons, plain text questions, or a combination of the two.
JSON Data Format for Questions

### Questions json

```

"questions": [
  {
    "id": 1,
    "question": "What language is your favorite?",
    "answerType": 1,
    "options": [
      "Kotlin",
      "Java",
      "C++"
    ]
  },
  {
    "id": 2,
    "question": "What do you like about programming?",
    "answerType": 0
  },
  {
    "id": 3,
    "question": "How was the assignment?",
    "answerType": 2,
    "options": [
      "Easy",
      "Normal",
      "Hard",
      "Other"
    ]
  }
]

```
