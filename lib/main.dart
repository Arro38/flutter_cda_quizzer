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
  List<List<String>> questions = [
    [
      "Vous venez de crevez un pneu à St André. Vous n'avez pas de téléphone vous décidez de faire du stop. Une ford fiesta blanche s'arrête et le conducteur vous demande si vous voulez qu'il vous dépanne.",
      "Vous lui remerciez et vous montez dans la voiture",
      "Vous lui demandez s'il n'est pas un meurtrier avant !"
    ],
    [
      "Il acquiesce de la tête sans faire attention à la question.",
      "Au moins il est honnête. Vous montez ! ",
      "Attends, mais je sais comment changer un pneu voyons !"
    ],
    [
      "Lorsqu'il commence à conduire, il vous demande d'ouvrir la boite à gant. À l’intérieur, vous trouverez un couteau ensanglanté, deux doigts coupés et un CD de T-Matt.",
      "J'adore T-Matt, je lui donne le CD.",
      " C'est lui ou moi, je prends le couteau et je le poignarde."
    ],
    ["Woaw ! Quelle évasion !", "Recommencer", ""],
    [
      "En traversant la route du littoral, vous réfléchissez à la sagesse douteuse de poignarder quelqu’un pendant qu’il conduit une voiture dans laquelle vous êtes.",
      "Recommencer",
      ""
    ],
    [
      "Vous vous faites un bon dalon et vous chantez le dernier son de T-matt ensemble. Il vous dépose à Cambaie et il vous demande si vous connaissez un bon endroit pour jeter un corps.",
      "Recommencer",
      ""
    ]
  ];

  int questionIndex = 0;

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
            });
          },
          width: 120,
        )
      ],
    ).show();
  }

  void handleClick(int choice) {
    if (questionIndex == 3 || questionIndex == 4 || questionIndex == 5) {
      // showAlert();
      setState(() {
        questionIndex = 0;
      });
    } else {
      setState(() {
        if (questionIndex == 0 && choice == 1) {
          questionIndex = 2;
        } else if (questionIndex == 0 && choice == 2) {
          questionIndex = 1;
        } else if (questionIndex == 1 && choice == 1) {
          questionIndex = 2;
        } else if (questionIndex == 1 && choice == 2) {
          questionIndex = 3;
        } else if (questionIndex == 2 && choice == 1) {
          questionIndex = 5;
        } else if (questionIndex == 2 && choice == 2) {
          questionIndex = 4;
        }
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
                        child: Text(questions[questionIndex][0],
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
                Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () => {handleClick(1)},
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              questions[questionIndex][1],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )))),
                SizedBox(height: 20),
                questions[questionIndex][2].isEmpty
                    ? SizedBox()
                    : Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () => {handleClick(2)},
                            child: Container(
                                width: double.infinity,
                                child: Text(
                                  questions[questionIndex][2],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )))),
              ],
            ),
          )),
    );
  }
}
