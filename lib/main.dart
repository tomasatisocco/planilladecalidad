import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Planilla de Calidad Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  LevelTwo _trainning = LevelTwo(arrowsPerEnd: 6, technical: 'Transferencia');

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
            Text('Tiros: ${_trainning.shotSecuence.length} \nSeries: ${_trainning._series}',
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

    if ((_trainning.shotSecuence.length) > (_trainning._series * _trainning.arrowsPerEnd)){
      setState(() {
        _trainning._series++;
      });
    }
  }
}

class FeelButton extends StatelessWidget {
  final Color color;
  final String title;
  final int counter;
  final onChanged;

  const FeelButton(
      {Key? key,
      required this.color,
      required this.counter,
      required this.title,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          MaterialButton(
            elevation: 0.0,
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Text('$counter',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
            ),
            onPressed: () {
              _onChanged();
            },
          ),
        ],
      ),
    );    
  }

  _onChanged() {
    onChanged(title);
  }
}

class LevelTwo{
  int arrowsPerEnd;
  int _series = 0;
  String technical;
  List <String> shotSecuence = [];

  LevelTwo({required this.arrowsPerEnd, required this.technical});
}
