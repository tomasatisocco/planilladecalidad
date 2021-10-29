import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/menuPage.dart';

class TrainningsPage extends StatefulWidget {
  TrainningsPage({Key? key}) : super(key: key);

  @override
  _TrainningsPageState createState() => _TrainningsPageState();
}

class _TrainningsPageState extends State<TrainningsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(trainning: Trainning())));
        },
      ),
    );
  }
}