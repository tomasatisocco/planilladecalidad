import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/pages/menuPage.dart';
import 'classes/trainning.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planilla de Calidad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/Menu',
      routes:{
        '/Menu':(BuildContext context) => MenuPage(trainning: Trainning(arrowsPerEnd: 6, technical: 'hola bobo'),),
      }
    );
  }
}
