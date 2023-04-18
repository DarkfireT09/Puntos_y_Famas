import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../MyHome.dart';
import '../controller/GameController.dart';

bool numerosRepetidos(String number) {
  Set<String> digitos = {};
  for (int i = 0; i < number.length; i++) {
    String digit = number[i];
    if (digitos.contains(digit)) {
      return true;
    }
    digitos.add(digit);
  }
  return false;
}

bool checkHexadecimal(String number) {
  List hexadecimals = ["A", "B", "C", "D", "E", "F", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  for (int i = 0; i < number.length; i++) {
    String digit = number[i];
    if (!hexadecimals.contains(digit)) {
      return false;
    }
  }
  return true;
}


class Versus extends StatefulWidget {

  @override
  State<Versus> createState() => _VersusState();
}

class _VersusState extends State<Versus> {
  GameController controller = Get.find();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],

      ),
      home: Scaffold(
        backgroundColor: Colors.lightGreen[200],
        body: Center(
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                margin: const EdgeInsets.all(30),

                child: Center(
                  child: Text(
                    'Jugador ' + controller.currentPlayer.toString()+ ' te toca: ' + controller.getTurn(),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.lightBlue[900]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(30),
                child: Center(
                  child: controller.setNumbers? null :Text(
                    'Famas: ' + controller.famas.toString(),
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  keyboardType: controller.dificultad.value == 4 ? TextInputType.text : TextInputType.number,
                  onSubmitted: (String value) {
                    value = value.toUpperCase();
                    if ((value.length != controller.getLen()) || (numerosRepetidos(value)) || !checkHexadecimal(value)){
                      AlertDialog alert = AlertDialog(
                        backgroundColor: Colors.deepOrange[300],
                        title: const Text("Error", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
                        content: Text("El numero debe tener " + controller.getLen().toString() + " digitos y sus entradas deben ser validas"),
                        actions: [
                          TextButton(
                            child: Text("Ok", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                            onPressed: () {
                              Get.back();
                              _controller.clear();
                            },
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                      return;
                    }
                    if (controller.setNumbers){
                      controller.a = value;
                      controller.setNumbers = false;
                      controller.currentPlayer = controller.currentPlayer == "A" ? "B" : "A";
                      _controller.clear();
                      controller.famas.clear();
                      controller.initFamas();
                      setState(() {});
                      return;
                    }
                    controller.intentos++;
                    controller.numero = value;
                    controller.comparar();
                    setState(() {});
                    if (controller.checkWin()){
                      controller.setNumbers = true;
                      if (controller.currentPlayer == "A"){
                        controller.intentosA = controller.intentos;
                        AlertDialog alert = AlertDialog(
                          backgroundColor: Colors.purpleAccent[400],
                          title: Text("Final del juego", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          content: controller.getWinner() == 'Empate'? Text("Fue empate") : Text("El ganador es " + controller.getWinner()),
                          actions: [
                            TextButton(
                              child: Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              onPressed: () {
                                controller.reset();
                                setState(() {});
                                Get.offAllNamed('/');
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        controller.intentosB = controller.intentos;
                        AlertDialog alert = AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: Text("Jugador B: ", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          content: Text(controller.intentosB.toString() + " intento/s"),
                          actions: [
                            TextButton(
                              child: Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              onPressed: () {
                                _controller.clear();
                                controller.resetP();
                                setState(() {});
                                Get.back();
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      controller.currentPlayer = controller.currentPlayer == "A" ? "B" : "A";


                    }


                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese un numero de ' + controller.getLen().toString() + ' digitos',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),

                child: controller.setNumbers? null :Text(
                  'Puntos: ' + controller.puntos.toString() + ' y Fallos: ' + controller.fallas.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
                child: controller.setNumbers? null :Text(
                  'Intentos: '+ controller.intentos.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.only(left: 10, right: 10),

                child: controller.setNumbers? null : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    controller.getHINT();
                    setState(() {});
                    if (controller.checkWin()){
                      controller.setNumbers = true;
                      if (controller.currentPlayer == "A"){
                        controller.intentosA = controller.intentos;
                        AlertDialog alert = AlertDialog(
                          backgroundColor: Colors.purpleAccent[400],
                          title: Text("Final del juego", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          content: controller.getWinner() == 'Empate'? Text("Fue empate") : Text("El ganador es " + controller.getWinner()),
                          actions: [
                            TextButton(
                              child: Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              onPressed: () {
                                controller.reset();
                                setState(() {});
                                Get.offAllNamed('/');
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        controller.intentosB = controller.intentos;
                        AlertDialog alert = AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: Text("Jugador B: ", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          content: Text(controller.intentosB.toString() + " intento/s"),
                          actions: [
                            TextButton(
                              child: Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              onPressed: () {
                                _controller.clear();
                                controller.resetP();
                                setState(() {});
                                Get.back();
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      controller.currentPlayer = controller.currentPlayer == "A" ? "B" : "A";


                    }
                  },
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('HINT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

