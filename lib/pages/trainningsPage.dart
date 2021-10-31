import 'dart:math';
import 'package:planilla_de_calidad/classes/dataBase.dart';
import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/menuPage.dart';

class TrainningsPage extends StatefulWidget {
  TrainningsPage({Key? key}) : super(key: key);

  @override
  _TrainningsPageState createState() => _TrainningsPageState();
}

class _TrainningsPageState extends State<TrainningsPage> {

  late Database _database;
  String estetesto = "jola";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          initialData: [],
          future: _loadDB(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : Text(estetesto);
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            _database.trainningsDB.add(Trainning(
              id: Random().nextInt(99999999).toString(),
              arrowsPerEnd: 6,
              date: DateTime.now().toString(),
              series: 0,
              shotSecuence: [], 
              technical: 'Select'
            ));
          });
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => MenuPage(
                database: _database,
                trainning: _database.trainningsDB.last,
              )
            )
          );
        },
      ),
    );
  }

  Future<List<Trainning>> _loadDB() async{
    await DatabaseFileRoutines().readDataBase().then((jsonTrainnings){
      _database = databaseFromJson(jsonTrainnings);
      _database.trainningsDB.sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
    });
    return _database.trainningsDB;
  }
}