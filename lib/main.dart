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
  late int _counter1;
  late int _counter2;
  late int _counter3;
  late int _counter4;

  @override
  void initState() {
    super.initState();
    _counter1 = 0;
    _counter2 = 0;
    _counter3 = 0;
    _counter4 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('${_counter1 + _counter2 + _counter3 + _counter4}'),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FeelButton(
                      color: Colors.amber,
                      title: 'Uno',
                      counter: _counter1,
                      onChanged: incrementCounter
                    ),
                  ),
                  Expanded(
                    child: FeelButton(
                      color: Colors.grey,
                      title: 'Dos',
                      counter: _counter2,
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
                      counter: _counter3,
                      onChanged: incrementCounter
                    ),
                  ),
                  Expanded( 
                    child: FeelButton(
                      color: Colors.brown,
                      title: 'Cuatro',
                      counter: _counter4,
                      onChanged: incrementCounter
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('$_counter1');
        },
      ),
    );
  }

  void incrementCounter(String title) {
    setState(() {
      _counter1 = (title == 'Uno') ? (_counter1 + 1) : _counter1;
      _counter2 = (title == 'Dos') ? (_counter2 + 1) : _counter2;
      _counter3 = (title == 'Tres') ? (_counter3 + 1) : _counter3;
      _counter4 = (title == 'Cuatro') ? (_counter4 + 1) : _counter4;
    });
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
