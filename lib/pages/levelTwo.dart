import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/widgets/feelButton.dart';

class LevelTwoPage extends StatefulWidget {
  LevelTwoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LevelTwoPageState createState() => _LevelTwoPageState();
}

class _LevelTwoPageState extends State<LevelTwoPage> {
  
  Trainning _trainning = Trainning(arrowsPerEnd: 6, technical: 'Transferencia');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(_trainning.technical),
        centerTitle: true,
      ),*/
      body: SafeArea(
        child: Stack(
          alignment: Alignment(-0.9, 0.95),
          children:<Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FeelButton(
                          color: Colors.amber,
                          title: 'Buena Sensacion\nBuen Tiro',
                          counter: _trainning.shotSecuence.where((element) => element == 'BB').length,
                          onChanged: incrementCounter
                        ),
                      ),
                      Expanded(
                        child: FeelButton(
                          color: Colors.redAccent,
                          title: 'Buena Sensacion\nMal Tiro',
                          counter: _trainning.shotSecuence.where((element) => element == 'BM').length,
                          onChanged: incrementCounter
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FeelButton(
                          color: Colors.blue,
                          title: 'Mala Sensacion\nBuen Tiro',
                          counter: _trainning.shotSecuence.where((element) => element == 'MB').length,
                          onChanged: incrementCounter
                        ),
                      ),
                      Expanded( 
                        child: FeelButton(
                          color: Colors.black,
                          title: 'Mala Sensacion\nMal Tiro',
                          counter: _trainning.shotSecuence.where((element) => element == 'MM').length,
                          onChanged: incrementCounter
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text('Tiros: ${_trainning.shotSecuence.length} \nSeries: ${_trainning.series}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _trainning.shotSecuence.forEach((element) {print(element);});
        },
      ),
    );
  }

  void incrementCounter(String title) {
    switch (title) {
      case 'Buena Sensacion\nBuen Tiro':
        setState(() {
          _trainning.shotSecuence.add('BB');
        });
        break;
      case 'Buena Sensacion\nMal Tiro':
        setState(() {
          _trainning.shotSecuence.add('BM');
        });
        break;
      case 'Mala Sensacion\nBuen Tiro':
        setState(() {
          _trainning.shotSecuence.add('MB');
        });  
        break;
      case 'Mala Sensacion\nMal Tiro':
        setState(() {
          _trainning.shotSecuence.add('MM');
        });
        break;
      default:
    }

    if ((_trainning.shotSecuence.length) > (_trainning.series * _trainning.arrowsPerEnd)){
      setState(() {
        _trainning.series++;
      });
    }
  }
}