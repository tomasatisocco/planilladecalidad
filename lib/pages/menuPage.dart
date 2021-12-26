import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:planilla_de_calidad/classes/dataBase.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/levelOne.dart';
import 'package:planilla_de_calidad/pages/levelTwo.dart';

class MenuPage extends StatefulWidget {

  final Trainning trainning;
  final Database database;

  MenuPage({Key? key, required this.trainning, required this.database}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  String value = 'Select';

  List <String> technique = [
    'Psicion de Pies','Agarre de Cuerda','Cuatro Pasos','Set','Brazo de Arco',
    'Hombro de Arco','T','Set Up','Tensado','Anclaje','Transferencia','Holding',
    'Moviemiento Escapular','Expansion - Apuntado','Suelta - Follow Through','Respiracion','Visualizaicon','Rutina','Seleccionar'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Image(image: AssetImage('assets/AALogo.png'),width: 100,),
              SizedBox(height: 20),
              Text('FECHA',textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontSize: 17),),
              TextButton(
                child: Text(widget.trainning.date.toString().substring(0,10), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                onPressed: (){
                  DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2015, 1, 1),
                    maxTime: DateTime(2030, 12, 24),
                    onConfirm: (date){
                      setState(() {
                        widget.trainning.date = date.toString();
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.es,   
                  );
                },
              ),
              SizedBox(height: 20,),
              Text('FLECHAS POR SERIE',textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontSize: 17),),
              Slider(
                min: 1,
                max: 18,
                divisions: 18,
                value: widget.trainning.arrowsPerEnd.toDouble(),
                label: '${widget.trainning.arrowsPerEnd}',
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                onChanged: (value){
                  setState(() {
                    widget.trainning.arrowsPerEnd = value.toInt();
                  });
                },
              ),
              Text('TECNICA',textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontSize: 17),),
              DropdownButton(
                dropdownColor: Colors.blueAccent.shade200,
                value: value,
                items: technique.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item, style: TextStyle(color: Colors.white))
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    value = newValue!;
                    widget.trainning.technical = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Text('ELEGIR NIVEL',textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontSize: 17),),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Nivel\n1',textAlign: TextAlign.center,),
                    onPressed: (){
                      setState(() {
                        widget.database.trainningsDB.last = widget.trainning;
                      });
                      DatabaseFileRoutines().writeDataBase(databaseToJson(widget.database));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LevelOne(trainning: widget.trainning, database: widget.database, index: widget.database.trainningsDB.length - 1)));
                    },
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    child: Text('Nivel\n2',textAlign: TextAlign.center,),
                    onPressed: (){
                  setState(() {
                    widget.database.trainningsDB.last = widget.trainning;
                  });
                  DatabaseFileRoutines().writeDataBase(databaseToJson(widget.database));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LevelTwoPage(trainning: widget.trainning, database: widget.database, index: widget.database.trainningsDB.length - 1)));
                },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}