

import 'package:batlle/ui/controller/GameController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MyHome.dart';
//Test

void main() {
  Get.lazyPut<GameController>(() => GameController());
  runApp(App());
}