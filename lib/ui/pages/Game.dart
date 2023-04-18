import 'package:confetti/confetti.dart';
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

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

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
                      'Vamos a jugar',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.lightBlue[900]),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                        'Famas: ' + controller.famas.toString(),
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
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
                              child: const Text("Ok", style: TextStyle(
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
                      controller.intentos++;
                      controller.numero = value;
                      controller.comparar();
                      setState(() {});
                      if (controller.checkWin()){
                        AlertDialog alert = AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: Text("Ganaste", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          content: Text("En " + controller.intentos.toString() + " intento/s"),
                          actions: [
                            TextButton(
                              child: Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              onPressed: () {
                                controller.reset();
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

                  child: Text(
                    'Puntos: ' + controller.puntos.toString() + ' y Fallos: ' + controller.fallas.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
                  child: Text(
                    'Intentos: '+ controller.intentos.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.only(left: 10, right: 10),

                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[900],
                      // the button must be circular
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),

                    ),
                    onPressed: () {
                      controller.getHINT();
                      setState(() {});
                      if (controller.checkWin()){
                        AlertDialog alert = AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: Text("Ganaste", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          content: Text("En " + controller.intentos.toString() + " intento/s"),
                          actions: [
                            TextButton(
                              child: Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                              onPressed: () {
                                controller.reset();
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
