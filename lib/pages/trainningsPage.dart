import 'dart:math';
import 'package:planilla_de_calidad/classes/dataBase.dart';
import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/levelOne.dart';
import 'package:planilla_de_calidad/pages/levelTwo.dart';
import 'package:planilla_de_calidad/pages/menuPage.dart';
import 'package:intl/intl.dart';

class TrainningsPage extends StatefulWidget {
  TrainningsPage({Key? key}) : super(key: key);

  @override
  _TrainningsPageState createState() => _TrainningsPageState();
}

class _TrainningsPageState extends State<TrainningsPage> {

  late Database _database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Trainning List'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          initialData: [],
          future: _loadDB(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index){
                return Divider(
                  color: Colors.blueAccent,
                );
              }, 
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(snapshot.data[index].shotSecuence.contains('B') || snapshot.data[index].shotSecuence.contains('M'))
                        Text('Level\n1', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                      if(!(snapshot.data[index].shotSecuence.contains('B') || snapshot.data[index].shotSecuence.contains('M')))
                        Text('Level\n2', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  title: Text(
                    snapshot.data[index].technical
                  ),
                  subtitle: Text(
                    snapshot.data[index].trainningProm
                  ),
                  trailing: Text(DateFormat.yMd().format(DateTime.parse(snapshot.data[index].date))),
                  onTap: (){
                    if((_database.trainningsDB[index].shotSecuence.contains('B')) || (_database.trainningsDB[index].shotSecuence.contains('M'))){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => LevelOne(
                            database: _database,
                            trainning: _database.trainningsDB[index],
                            index: index,
                          )
                        )
                      ).then((value) => setState((){}));
                    } else {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => LevelTwoPage(
                            database: _database,
                            trainning: _database.trainningsDB[index],
                            index: index,
                          )
                        )
                      ).then((value) => setState((){}));
                    }
                  },
                  onLongPress: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Eliminar'),
                          content: Text('Desea Eliminar Este Entrenamiento?'),
                          backgroundColor: Colors.blue[600],
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar',style: 
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              }
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            TextButton(
                              child: Text('Eliminar',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              onPressed: (){
                                setState(() {
                                  _database.trainningsDB.removeAt(index);                                  
                                });
                                DatabaseFileRoutines().writeDataBase(databaseToJson(_database));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }
                    );
                  },
                );
              },
            );
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
          ).then((_) => setState((){}));
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