
import 'package:batlle/ui/pages/Game.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:batlle/ui/controller/GameController.dart';
import 'package:batlle/ui/pages/versus.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  GameController controller = Get.find();
  Color? color11 = Colors.lightBlue[900];
  Color? color12 = Colors.lightBlue[900];
  Color? color13 = Colors.lightBlue[900];
  Color? color14 = Colors.lightBlue[900];

  Color? color21 = Colors.lightBlue[900];
  Color? color22 = Colors.lightBlue[900];


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Puntos y Famas',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
      ),
      home: Scaffold(
        backgroundColor: Colors.lightGreen[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30),

                child: Text(
                  'Puntos y Famas',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.lightBlue[900]),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),

                child: Text(
                  'Seleccione la dificultad',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.lightBlue[900]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color11,
                      ),
                      onPressed: () {
                        color11 = Colors.pink[800];
                        color14 = Colors.lightBlue[900];
                        color12 = Colors.lightBlue[900];
                        color13 = Colors.lightBlue[900];
                        controller.changeDificultad(1);
                        setState(() {});
                      },
                      child: const Text('Facil'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color12,
                      ),
                      onPressed: () {
                        color12 = Colors.pink[800];
                        color11 = Colors.lightBlue[900];
                        color14 = Colors.lightBlue[900];
                        color13 = Colors.lightBlue[900];
                        controller.changeDificultad(2);
                        setState(() {});
                      },
                      child: const Text('Medio'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color13,
                      ),
                      onPressed: () {
                        color13 = Colors.pink[800];
                        color11 = Colors.lightBlue[900];
                        color12 = Colors.lightBlue[900];
                        color14 = Colors.lightBlue[900];
                        controller.changeDificultad(3);
                        setState(() {});
                      },
                      child: const Text('Dificil'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color14,
                      ),
                      onPressed: () {
                        color14 = Colors.pink[800];
                        color11 = Colors.lightBlue[900];
                        color12 = Colors.lightBlue[900];
                        color13 = Colors.lightBlue[900];
                        controller.changeDificultad(4);
                        setState(() {});
                      },
                      child: const Text('Letal'),
                    ),
                  ),
                 
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color21,
                      ),
                      onPressed: () {
                        color21 = Colors.pink[800];
                        color22 = Colors.lightBlue[900];
                        controller.changeTipo(1);
                        setState(() {});
                      },
                      child: const Text('Solitario'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color22,
                      ),
                      onPressed: () {
                        color22 = Colors.pink[800];
                        color21 = Colors.lightBlue[900];
                        controller.changeTipo(2);
                        setState(() {});
                      },
                      child: const Text('Versus'),
                    ),
                  ),

                ],
              ),
              Container(
                margin: const EdgeInsets.all(30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[900],
                    ),
                    onPressed: () {
                      if (controller.tipo != 0 && controller.dificultad != 0)  {
                        if (controller.tipo == 1) {
                          if (controller.dificultad == 1) {
                            controller.randomNumber(3);
                          } else if (controller.dificultad == 2) {
                            controller.randomNumber(4);
                          } else if (controller.dificultad == 3) {
                            controller.randomNumber(5);
                          } else {
                            controller.randomHexa();
                          }
                          controller.initFamas();
                          color11 = Colors.lightBlue[900];
                          color12 = Colors.lightBlue[900];
                          color13 = Colors.lightBlue[900];
                          color14 = Colors.lightBlue[900];
                          color21 = Colors.lightBlue[900];
                          color22 = Colors.lightBlue[900];
                          setState(() {});
                          Get.to(() => Game());
                        } else {
                          color11 = Colors.lightBlue[900];
                          color12 = Colors.lightBlue[900];
                          color13 = Colors.lightBlue[900];
                          color14 = Colors.lightBlue[900];
                          color21 = Colors.lightBlue[900];
                          color22 = Colors.lightBlue[900];
                          setState(() {});
                          Get.to(() => Versus());
                        }
                      }
                    },
                    child: const Text('Empezar')),
              ),
              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Game By: Camilo Fernandez',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
