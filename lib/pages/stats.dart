import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';

class StatsPage extends StatelessWidget {

  final Trainning actualTrainning;

  const StatsPage({Key? key, required this.actualTrainning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadisticas'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: actualTrainning.shotSecuence.length,
          itemBuilder: (context, index) => 
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: shotColor(actualTrainning.shotSecuence[index]),
              ),
              child: Text(actualTrainning.shotSecuence[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: actualTrainning.arrowsPerEnd,
          ),
        ),
      ),
    );
  }

  Color shotColor(String shot){
    Color _color;
    switch (shot) {
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
      default: _color = Colors.green;
    }
    return _color;
  }
}