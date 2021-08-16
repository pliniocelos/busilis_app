import 'dart:convert';
import 'package:busilisapp/ui/components/button_next_question.dart';
import 'package:busilisapp/ui/components/card_question.dart';
import 'package:busilisapp/ui/components/text_correct_answers_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/question.dart';

class TestScreen extends StatefulWidget {

  final String urlBase = "https://pliniocelos.wixsite.com/site/_functions/questions/";

  bool chooseP;
  bool chooseM;
  bool chooseH;
  bool chooseG;
  bool chooseC;

  int qtdQuestions;

  bool isFirstTimeLoading = true;

  TestScreen(this.chooseP, this.chooseM, this.chooseH, this.chooseG,
      this.chooseC, this.qtdQuestions);

  int indexOfArrayQuestionsCurrentQuestion = 0;
  int numCorrectAnswers = 0;

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String fullUrl;
  List<Question> list;

  Future<List<Question>> _getQuestions() async {
    if (widget.isFirstTimeLoading) {
      http.Response response = await http.get(Uri.parse(fullUrl));
      var dadosJson = json.decode(response.body);

      List<Question> questions = [];

      for (var question in dadosJson) {
        Question q = Question(
            question["question"],
            question["a"],
            question["b"],
            question["c"],
            question["correct"],
            question["category"],
            question["_id"]);

        questions.add(q);
      }
      return questions;
    } else {
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    int numQuestions = widget.qtdQuestions;

    Question question;

    getRatingResultsText() {
      if (widget.numCorrectAnswers == numQuestions) {
        return "Você é o melhor!";
      } else if ((widget.numCorrectAnswers / numQuestions) >= 0.7) {
        return "Ótima média!";
      } else if ((widget.numCorrectAnswers / numQuestions) >= 0.4) {
        return "Ainda pode melhorar.";
      } else if ((widget.numCorrectAnswers / numQuestions) < 0.4) {
        return "Quem sabe na próxima?";
      }
    }

    bool isLastQuestion() {
      if (widget.indexOfArrayQuestionsCurrentQuestion == list.length - 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Color(0xff721C1E),
                title: Center(
                    child: Text(
                  getRatingResultsText(),
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )),
                content: //Center(child:
                    Text(
                        "Você acertou ${widget.numCorrectAnswers} de $numQuestions perguntas"),
                //),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Ok"))
                ],
              );
            });

        return true;
      } else {
        return false;
      }
    }

    bool p = widget.chooseP;
    bool m = widget.chooseM;
    bool h = widget.chooseH;
    bool g = widget.chooseG;
    bool c = widget.chooseC;

    getRatingText() {
      return "Acertos: " +
          widget.numCorrectAnswers.toString() +
          " / " +
          numQuestions.toString();
    }

    fullUrl = widget.urlBase +
        numQuestions.toString() +
        "?chooseP=" +
        p.toString() +
        "&chooseM=" +
        m.toString() +
        "&chooseH=" +
        h.toString() +
        "&chooseG=" +
        g.toString() +
        "&chooseC=" +
        c.toString();

    print(fullUrl);

    //Example URL: "https://pliniocelos.wixsite.com/busilis/_functions/questions/10?chooseP=true&chooseM=true&chooseH=true&chooseG=true&chooseC=true"

    //This key is to refresh the text of the child widget
    final GlobalKey<TextCorrectAnswersBarState> _keyTextCorrectAnswersBar =
        GlobalKey();
    final GlobalKey<ButtonNextQuestionState> _keyButtonNextQuestion =
        GlobalKey();

    callNextQuestion() {
      widget.indexOfArrayQuestionsCurrentQuestion++;
      setState(() {
        Question q = list[widget.indexOfArrayQuestionsCurrentQuestion];

        question.question = q.question;
        question.a = q.a;
        question.b = q.b;
        question.c = q.c;
        question.correct = q.correct;
        question.category = q.category;
        question.id = q.id;
      });
    }

    return Scaffold(
        backgroundColor: Color(0xff721C1E),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage('images/app_logo.png'),
                height: 40,
              ),
              TextCorrectAnswersBar(_keyTextCorrectAnswersBar, getRatingText()),
              ButtonNextQuestion(_keyButtonNextQuestion, callNextQuestion),
            ],
          ),
          backgroundColor: Color(0xff5e0908),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/app_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder<List<Question>>(
                future: _getQuestions(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      print("TEST - CONNECTION OK");
                      if (snapshot.hasError) {
                        print("TEST - CONNECTION ERROR");
                      } else {
                        widget.isFirstTimeLoading = false;
                        print("TEST - LIST BUILDED");
                        list = snapshot.data;

                        question =
                            list[widget.indexOfArrayQuestionsCurrentQuestion];
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              QuestionProvider(question,
                                  child: CardQuestion(
                                    (widget.indexOfArrayQuestionsCurrentQuestion +
                                        1)
                                        .toString(),
                                        (correct) {
                                      _keyButtonNextQuestion.currentState
                                          .methodInChild(isLastQuestion());

                                      print(_keyButtonNextQuestion.toString());

                                      if (correct) {
                                        widget.numCorrectAnswers++;

                                        _keyTextCorrectAnswersBar.currentState
                                            .methodInChild(getRatingText());

                                        print('RETURN OF BUTTON NEXT - FALSE');
                                      } else {}
                                    },
                                  )),
                            ],
                          )
                        );
                      }
                      break;
                  }
                  return null;
                })));
  }

  buildBody(
      Question question,
      GlobalKey<ButtonNextQuestionState> _keyButtonNextQuestion,
      Function isLastQuestion,
      GlobalKey<TextCorrectAnswersBarState> _keyTextCorrectAnswersBar,
      Function getRatingText) {}
}

class QuestionProvider extends InheritedWidget {

  final Question question;

  QuestionProvider(this.question, {Key key, this.child})
      : super(key: key, child: child);


  final Widget child;

  static QuestionProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<QuestionProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }
}
