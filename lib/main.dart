// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<String> questions = [
    "La terre est ronde",
    "La terre est plate",
    "La terre est un cube"
  ];

  List<bool> answers = [true, false, false];
  int questionIndex = 0;

  List<Icon> listIcon = [];

  void showAlert() {
    Alert(
      context: navigatorKey.currentContext!,
      type: AlertType.success,
      title: "Quizz Terminé",
      desc: "Redémarrer le quizz ?",
      closeFunction: () {},
      buttons: [
        DialogButton(
          child: Text(
            "Oui",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(navigatorKey.currentContext!);
            // refresh the state
            setState(() {
              questionIndex = 0;
              listIcon = [];
            });
          },
          width: 120,
        )
      ],
    ).show();
  }

  void handleClick(bool answer) {
    setState(() {
      if (answer == answers[questionIndex]) {
        listIcon.add(Icon(Icons.check, color: Colors.green));
      } else {
        listIcon.add(Icon(Icons.close, color: Colors.red));
      }
    });
    if (questionIndex + 1 == questions.length) {
      showAlert();
    } else {
      setState(() {
        questionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Center(
                        child: Text(questions[questionIndex],
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () => {handleClick(true)},
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              "Vrai",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )))),
                SizedBox(height: 20),
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () => {handleClick(false)},
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              "Faux",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )))),
                Expanded(
                  child: Row(children: listIcon),
                )
              ],
            ),
          )),
    );
  }
}
