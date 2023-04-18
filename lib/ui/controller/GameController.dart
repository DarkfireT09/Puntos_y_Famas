import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';


class GameController extends GetxController {
  var dificultad = 0.obs;
  var tipo = 0.obs;
  String a = '';
  int intentos = 0;
  var famas = [].obs;
  var puntos = [].obs;
  var fallas = [].obs;
  String numero = '';

  String currentPlayer = "A";
  int intentosA = 0;
  int intentosB = 0;
  bool setNumbers = true;

  String getTurn(){
    if (setNumbers){
      return "Elegir el numero";
    } else {
      return "Adivinar el numero";
    }
  }

  void changeDificultad(int d) {
    dificultad.value = d;
  }


  int getLen(){
    if (dificultad.value == 1){
      return 3;
    } else if (dificultad.value == 2){
      return 4;
    } else if (dificultad.value == 3 || dificultad.value == 4){
      return 5;
    } else{
      return 0;
    }
  }

  void changeTipo(int d) {
    tipo.value = d;
  }

  void randomNumber(int d){
    var random = Random();
    for(int i = 0; i < d; i++){
      int randomNumber = random.nextInt(10);
      while (a.contains('$randomNumber')){
        randomNumber = random.nextInt(10);
      }
      a +='$randomNumber';
    }
  }

  void randomHexa(){
    var random = Random();
    for(int i = 0; i < 5; i++){
      String randomNumber = random.nextInt(16).toString();
      if (randomNumber == '10'){
        randomNumber = 'A';
      } else if (randomNumber == '11'){
        randomNumber = 'B';
      } else if (randomNumber == '12'){
        randomNumber = 'C';
      } else if (randomNumber == '13'){
        randomNumber = 'D';
      } else if (randomNumber == '14'){
        randomNumber = 'E';
      } else if (randomNumber == '15'){
        randomNumber = 'F';
      }
      while (a.contains(randomNumber)){
        randomNumber = random.nextInt(16).toString();
        if (randomNumber == '10'){
          randomNumber = 'A';
        } else if (randomNumber == '11'){
          randomNumber = 'B';
        } else if (randomNumber == '12'){
          randomNumber = 'C';
        } else if (randomNumber == '13'){
          randomNumber = 'D';
        } else if (randomNumber == '14'){
          randomNumber = 'E';
        } else if (randomNumber == '15'){
          randomNumber = 'F';
        }
      }
      a +=randomNumber;
    }
  }

  void initFamas(){
    for (int i = 0; i < getLen(); i++){
      famas.add("*");
    }
  }

  void comparar(){
    for (int i = 0; i < a.length; i++){
      if (a.contains(numero[i])){
        if (a[i] == numero[i]){
          if (!famas.contains(numero[i])){
            famas[i] = numero[i];
            if (puntos.contains(numero[i])){
              puntos.remove(numero[i]);
            }
          }
        } else {
          if (!puntos.contains(numero[i])){
            puntos.add(numero[i]);
          }
        }
      } else {
        if (!fallas.contains(numero[i])){
          fallas.add(numero[i]);
        }
      }
    }
  }

  bool checkWin(){
    if (famas.length == getLen() && !famas.contains("*")){

      return true;
    }
    return false;
  }

  String getWinner(){
    if (intentosA < intentosB){
      return "A";
    } else if (intentosA > intentosB){
      return "B";
    } else {
      return "Empate";
    }
  }

  void getHINT(){
    for (int i = 0; i < a.length; i++){
      if (famas[i] == "*"){
        famas[i] = a[i];
        if (puntos.contains(a[i])){
          puntos.remove(a[i]);
        }
        intentos += 5;
        break;
      }
    }
  }

  void reset(){
    a = '';
    dificultad.value = 0;
    tipo.value = 0;
    intentos = 0;
    famas.clear();
    puntos.clear();
    fallas.clear();
    numero = '';
    currentPlayer = "A";
    intentosA = 0;
    intentosB = 0;
    setNumbers = true;
  }

  void resetP(){
    a = '';
    intentos = 0;
    famas.clear();
    puntos.clear();
    fallas.clear();
    numero = '';
    currentPlayer = "B";
  }

}
