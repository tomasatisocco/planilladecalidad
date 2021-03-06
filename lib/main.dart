import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/pages/trainningsPage.dart';

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
      initialRoute: '/Trainnings',
      routes:{
        '/Trainnings':(BuildContext context) => TrainningsPage(),
      }
    );
  }
}
