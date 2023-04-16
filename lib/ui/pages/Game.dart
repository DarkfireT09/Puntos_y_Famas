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


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Solitario'),
          ),

          body: Center(
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  margin: const EdgeInsets.all(30),

                  child: Text(
                    'Vamos a jugar',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    keyboardType: controller.dificultad.value == 4 ? TextInputType.phone : TextInputType.number,
                    onSubmitted: (String value) {
                      if ((value.length != controller.getLen()) || (numerosRepetidos(value)) || !checkHexadecimal(value)){
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("El numero debe tener " + controller.getLen().toString() + " digitos y sus entradas deben ser validas"),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
                              onPressed: () {
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
                        return;
                      }
                      controller.intentos++;
                      controller.numero = value;
                      controller.comparar();
                      setState(() {});
                      if (controller.checkWin()){
                        AlertDialog alert = AlertDialog(
                          title: Text("Ganaste"),
                          content: Text("En " + controller.intentos.toString() + " intento/s"),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
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
                    'Intentos: '+ controller.intentos.toString() + ', tienes famas: ' + controller.famas.toString() + ', puntos: ' + controller.puntos.toString() + ' y has fallado en: ' + controller.fallas.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),

                  child: ElevatedButton(
                    onPressed: () {
                      controller.getHINT();
                      setState(() {});
                      if (controller.checkWin()){
                        AlertDialog alert = AlertDialog(
                          title: Text("Ganaste"),
                          content: Text("En " + controller.intentos.toString() + " intento/s"),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
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
                    child: const Text('HINT'),
                  ),
                ),



              ],
            ),
          ),

      ),
    );
  }
}
