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
          alignment: Alignment.center,
          children:<Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FeelButton(
                          color: Colors.amber,
                          title: 'Uno',
                          counter: _trainning._counter1,
                          onChanged: incrementCounter
                        ),
                      ),
                      Expanded(
                        child: FeelButton(
                          color: Colors.grey,
                          title: 'Dos',
                          counter: _trainning._counter2,
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
                          color: Colors.blueGrey,
                          title: 'Tres',
                          counter: _trainning._counter3,
                          onChanged: incrementCounter
                        ),
                      ),
                      Expanded( 
                        child: FeelButton(
                          color: Colors.brown,
                          title: 'Cuatro',
                          counter: _trainning._counter4,
                          onChanged: incrementCounter
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
            Text('Tiros: ${_trainning._counter1 + _trainning._counter2 + _trainning._counter3 + _trainning._counter4} \nSeries: ${_trainning._series}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('$_trainning._counter1');
        },
      ),
    );
  }

  void incrementCounter(String title) {
    setState(() {
      _trainning._counter1 = (title == 'Uno') ? (_trainning._counter1 + 1) : _trainning._counter1;
      _trainning._counter2 = (title == 'Dos') ? (_trainning._counter2 + 1) : _trainning._counter2;
      _trainning._counter3 = (title == 'Tres') ? (_trainning._counter3 + 1) : _trainning._counter3;
      _trainning._counter4 = (title == 'Cuatro') ? (_trainning._counter4 + 1) : _trainning._counter4;
    });

    if ((_trainning._counter1 + _trainning._counter2 + _trainning._counter3 + _trainning._counter4) > (_trainning._series * _trainning.arrowsPerEnd)){
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
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: MaterialButton(
              elevation: 0.0,
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Text('$counter',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              onPressed: () {
                _onChanged();
              },
            ),
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
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;
  int _counter4 = 0;
  int _series = 0;
  String technical;

  LevelTwo({required this.arrowsPerEnd, required this.technical});


}
