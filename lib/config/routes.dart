import 'package:flutter/material.dart';
import 'package:flutter_machine_test/view/addProduct/addProduct.dart';
import 'package:flutter_machine_test/view/home/view/homePage.dart';

Map<String, Widget Function(BuildContext)> routes = {

  '/homePage': (context) => const HomePage(),
  '/addProduct': (context) => const AddProduct(),

};