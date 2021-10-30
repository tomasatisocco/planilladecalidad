import 'package:flutter/material.dart';

class Trainning{
  String id;
  int arrowsPerEnd = 6;
  int series = 0;
  String technical = 'Select';
  List <String> shotSecuence = [];
  DateTime date = DateTime.now();

  Trainning({required this.id});

  void completeShotSecuence(){
    int i = shotSecuence.length;

    if (shotSecuence.length != (series * arrowsPerEnd)){
      shotSecuence.length = series * arrowsPerEnd;
      shotSecuence.fillRange(i, shotSecuence.length, '');
    }
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
}