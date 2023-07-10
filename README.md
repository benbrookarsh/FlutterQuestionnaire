# FlutterQuestionnaire

Thought process for data format: 
I considered using an enum for the multiple choice answers to make the HTTP requests more efficient 
however i felt that for the added complexity and running the risk of having a mis match of data
that the integrity of the data was more important than optimising the HTTP request.

Having the data as a string value for each question also makes the data easier to read for whoever is receiving the
answers and from there on are free to use and manipulate the data however they see fit saving them the process of parsing 
enums for answers matching to the actual values. 

Taking this into consideration i decided to return string values to the server both for radio buttons and plain text answers, 
displaying what i feel the most readable format to present the answer data matching the questionId to its question.

Json Data format for Answers: 

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



As for the questions, i decided to give each question an enum as to its answer type for the purpose to display correctly 
in the flutter UI, this enum is in the file 'answer_type_enum.dart'.

Bases on this enum, the UI can draw the QuestionWidget as intended, being multiple choice with radio buttons, plain text, or a
combination of the two.

Json Data format for Questions: 

  "questions": [
    {
      "id": 1,
      "question": "What language is your favourite?",
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


