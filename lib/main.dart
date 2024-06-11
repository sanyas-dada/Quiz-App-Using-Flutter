import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizbrain.dart';

Quizbrain quizbrain = Quizbrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        /* leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                  onPressed: (){Scaffold.of(context).openDrawer();},
                  icon: const Icon(Icons.menu),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            }
          ),*/
        title: const Text(
          "Quiz App",
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20.0,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      body: const SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0), child: QuizPage()),
      ),
    ));
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() {
    return _QuizPageState();
  }
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreList = [];

  void userCheckedAnswer(bool checkedAnswer) {
    bool correctAnswer = quizbrain.getQuestionCheck();
    setState(() {
      if (checkedAnswer == correctAnswer) {
        scoreList.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreList.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      try {
        if (quizbrain.nextQuestion() < quizbrain.totalNumberOfQuestionBank()) {}
      } on RangeError catch (_, e) {
        Alert(
          context: context,
          title: "Finish",
          desc: "You've reached the end of the quiz",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "CANCEL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
        scoreList.length = 0;
      }
    });
  }

  /* List<String> questionList = [
    'i am going to pursue my  master in computer science.T',
    'I am going to manage my studying time and working time.T',
    'I can study 20 hours a day.F',
    'I work out daily.T'
  ];
  List<bool> answers = [true,true,false,true];*/
  //int questionNumber = 0;
  /* List<Question> questionlist =[
    Question("I am going to pursue my master in computer science", true),
    Question("I am going to manage my studying time and working time", true),
    Question("I can study 20 hours a day", false),
    Question("I am going to manage time effective way", true),
    Question("I work out daily", true),
    Question("I am excited to start my new journey in UK", true)
    ?? In order to meshing up around the code in the main.dart file , we need to use the abstraction method in the class.so we are using here
    by making another class for quesitonBank. did you understand why I am making this another class for this question list. Yeah, to separate the code between resuability and clearn
    cleaner way . thanks to the abstraction
  ];*/
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              onPressed: () {
                userCheckedAnswer(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                userCheckedAnswer(false);

                /* bool correctAnswer = quizbrain.getQuestionCheck();
                if(correctAnswer == false ){
                  debugPrint('User go it right');
                }else{
                  debugPrint('User got it wrong');
                }
                setState(() {
                  quizbrain.nextQuestion();
                });*/
              },
            ),
          ),
        ),
        Row(
          children: scoreList,
        ),
      ],
    );
  }
}
