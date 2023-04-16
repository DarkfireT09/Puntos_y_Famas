
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
  Color color11 = Colors.blue;
  Color color12 = Colors.blue;
  Color color13 = Colors.blue;
  Color color14 = Colors.blue;

  Color color21 = Colors.blue;
  Color color22 = Colors.blue;


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Puntos y Famas',
      theme: ThemeData(
        fontFamily: 'Michroma',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Puntos y Famas'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Puntos y Famas',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Seleccione la dificultad',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
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
                        color11 = Colors.red;
                        color14 = Colors.blue;
                        color12 = Colors.blue;
                        color13 = Colors.blue;
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
                        color12 = Colors.red;
                        color11 = Colors.blue;
                        color14 = Colors.blue;
                        color13 = Colors.blue;
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
                        color13 = Colors.red;
                        color11 = Colors.blue;
                        color12 = Colors.blue;
                        color14 = Colors.blue;
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
                        color14 = Colors.red;
                        color11 = Colors.blue;
                        color12 = Colors.blue;
                        color13 = Colors.blue;
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
                        color21 = Colors.red;
                        color22 = Colors.blue;
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
                        color22 = Colors.red;
                        color21 = Colors.blue;
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
                          color11 = Colors.blue;
                          color12 = Colors.blue;
                          color13 = Colors.blue;
                          color14 = Colors.blue;
                          color21 = Colors.blue;
                          color22 = Colors.blue;
                          setState(() {});
                          Get.to(() => Game());
                        } else {
                          color11 = Colors.blue;
                          color12 = Colors.blue;
                          color13 = Colors.blue;
                          color14 = Colors.blue;
                          color21 = Colors.blue;
                          color22 = Colors.blue;
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
