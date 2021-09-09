import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _counter2 = 0;
  int _counter3 = 0;
  int _counter4 = 0;

  @override
  void initState() { 
    super.initState();
    _counter1 = 0;  
  }

  void _updateCount1(i){
    setState(() {
      _counter1++;
    });
  }

  void _updateCount2(i){
    setState(() {
      _counter2++;
    });
  }

  void _updateCount3(i){
    setState(() {
      _counter3++;
    });
  }

  void _updateCount4(i){
    setState(() {
      _counter4++;
    });
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
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FeelButton(color: Colors.amber, title: 'Cuatro', counter: _counter1, parentAction: _updateCount1,),
                  FeelButton(color: Colors.grey, title: 'Dos', counter: _counter2, parentAction: _updateCount2,)
                ],
              )
            ),
            Expanded(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FeelButton(color: Colors.blueGrey, title: 'Tres', counter: _counter3, parentAction: _updateCount3,),
                  FeelButton(color: Colors.brown, title: 'Cuatro', counter: _counter4, parentAction: _updateCount4,)
                ],
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('$_counter1');
        },
      ),
    );
  }
}

class FeelButton extends StatefulWidget {
  final Color color;
  final String title;
  final int counter;
  final ValueSetter<int> parentAction;

  FeelButton({Key? key, required this.color, required this.title, required this.counter, required this.parentAction}) : super(key: key);

  @override
  _FeelButtonState createState() => _FeelButtonState();
}

class _FeelButtonState extends State<FeelButton> {

  _FeelButtonState();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: <Widget>[
          Text(widget.title,
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,),
          ),
          Expanded(
            child:MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              elevation: 0.0,
              child: Text('${widget.counter}', 
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              ),
              onPressed: (){
                widget.parentAction(widget.counter);
              },
            ),
          ),
        ],
      ),
    );
  }
}
