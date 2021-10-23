import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/pages/levelTwo.dart';
import 'package:planilla_de_calidad/pages/stats.dart';
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
      initialRoute: '/LevelTwo',
      routes:{
        '/LevelTwo':(BuildContext context) => LevelTwoPage(),
        '/Stats':(BuildContext context) => StatsPage(actualTrainning: Trainning(arrowsPerEnd: 6,technical: ''),),
      }
    );
  }
}
