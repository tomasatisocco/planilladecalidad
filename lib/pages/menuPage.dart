import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/levelOne.dart';
import 'package:planilla_de_calidad/pages/levelTwo.dart';

class MenuPage extends StatefulWidget {

  final Trainning trainning;

  MenuPage({Key? key, required this.trainning}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
              Text('AA Image Assets'),
              Row(
                children: <Widget>[
                  Text('Flechas por Serie: '),

                ],
              ),
              Text('Technical Aspect'),
              TextButton(
                child: Text('Level One'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LevelOne(trainning: widget.trainning,)));
                },
              ),
              TextButton(
                child: Text('Level Two'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LevelTwoPage(trainning: widget.trainning,)));
                },
              ),
              TextButton(
                child: Text(widget.trainning.date.toString().substring(0,10)),
                onPressed: (){
                  DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2015, 1, 1),
                    maxTime: DateTime(2030, 12, 24),
                    onConfirm: (date){
                      setState(() {
                        widget.trainning.date = date;
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.es         
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}