import 'package:flutter/material.dart';

class Trainning{
  String id;
  int arrowsPerEnd;
  int series ;
  String technical;
  List<dynamic> shotSecuence;
  String date;

  Trainning({
    required this.id, required this.arrowsPerEnd, required this.series, 
    required this.technical, required this.shotSecuence, required this.date
  });

  void completeShotSecuence(){
    int i = shotSecuence.length;

    if (shotSecuence.length != (series * arrowsPerEnd)){
      shotSecuence.length = series * arrowsPerEnd;
      shotSecuence.fillRange(i, shotSecuence.length, '');
    }
  }

  String trainningProm(){
    String _prom =  shotSecuence.length.toString();
    return _prom;
  }

  Color shotColor(String shot){
    Color _color;
    switch (shot) {
      case 'B':
        _color = Colors.green;
        break;
      case 'M':
        _color = Colors.red;
        break;
      case 'BB':
        _color = Colors.amber;
        break;
      case 'BM':
        _color = Colors.red;
        break;
      case 'MB':
        _color = Colors.blue;
        break;
      case 'MM':
        _color = Colors.black;
        break;
      default: _color = Colors.transparent;
    }
    return _color;
  }

  void removeBlanks(){
    shotSecuence.removeWhere((element) => element == '');
  }

  factory Trainning.formJson(Map<String, dynamic> jsonFile) => Trainning(
    id: jsonFile["id"],
    arrowsPerEnd : jsonFile["arrowsPerEnd"],
    series: jsonFile["series"],
    technical: jsonFile["technical"],
    shotSecuence: jsonFile["shotSecuence"],
    date: jsonFile["date"],
  );

  Map<String, dynamic> toJson() =>{
    "id": id,
    "arrowsPerEnd": arrowsPerEnd,
    "series": series,
    "technical": technical,
    "shotSecuence": shotSecuence,
    "date": date
  };
  
}