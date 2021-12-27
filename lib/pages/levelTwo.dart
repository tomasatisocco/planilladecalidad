import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/dataBase.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/stats.dart';
import 'package:planilla_de_calidad/widgets/circularButton.dart';

class LevelTwoPage extends StatefulWidget {
  final Trainning trainning;
  final Database database;
  final int index;

  LevelTwoPage({Key? key, required this.trainning, required this.database, required this.index}) : super(key: key);

  @override
  _LevelTwoPageState createState() => _LevelTwoPageState();
}

class _LevelTwoPageState extends State<LevelTwoPage> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation degOneTransformAnimation;
  late Animation rotationAnimation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTransformAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:<Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.green,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Text(
                          'Sensacion Lograda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        MaterialButton(
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Text('${widget.trainning.shotSecuence.where((element) => element == 'BB' || element == 'BM').length}',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LevelTwoFinal()))
                            .then((impact) {
                              if(impact == 'Buen Tiro'){
                                incrementCounter('Buena Sensacion\nBuen Tiro');
                              } else if (impact == 'Mal Tiro'){
                                incrementCounter('Buena Sensacion\nMal Tiro');
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )    
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Text(
                          'Sensacion No Lograda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        MaterialButton(
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Text('${widget.trainning.shotSecuence.where((element) => element == 'MM' || element == 'MB').length}',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LevelTwoFinal()))
                            .then((impact){
                              if(impact == 'Buen Tiro'){
                                incrementCounter('Mala Sensacion\nBuen Tiro');
                              } else if (impact == 'Mal Tiro') {
                                incrementCounter('Mala Sensacion\nMal Tiro');
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
            Positioned(
              bottom:30.0,
              left: 30.0,
              child: Text('Tiros: ${widget.trainning.shotSecuence.length} \nSeries: ${widget.trainning.series}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start
              ),
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: SizedBox(
                width: 300,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(-240.0 * degOneTransformAnimation.value, 0.0),
                      child: Transform(
                        transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)..scale(degOneTransformAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.lightBlueAccent,
                          width: 50,
                          height: 50,
                          icon: Icon(Icons.remove, color: Colors.white),
                          tooltip: 'Borrar Ultimo', 
                          onPress: (){ 
                           decrementCounter();
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-170.0 * degOneTransformAnimation.value, 0.0),
                      child: Transform(
                        transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)..scale(degOneTransformAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.blueGrey,
                          width: 50,
                          height: 50,
                          icon: Icon(Icons.check, color: Colors.white),
                          tooltip: 'Ver resultados', 
                          onPress: (){
                            widget.trainning.completeShotSecuence();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StatsPage(trainning: widget.trainning)));
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-100.0 * degOneTransformAnimation.value, 0.0),
                      child: Transform(
                        transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)..scale(degOneTransformAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.orangeAccent,
                          width: 50,
                          height: 50,
                          icon: Icon(Icons.home, color: Colors.white), 
                          tooltip: 'Home',
                          onPress: (){
                            Navigator.popUntil(context, ModalRoute.withName('/Trainnings'));
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Transform(
                        transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)
                        ..scale(degOneTransformAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.white, 
                          width: 40, 
                          height: 40, 
                          icon: Icon(Icons.close), 
                          tooltip: 'Cancelar',
                          onPress: (){
                            animationController.reverse();
                          }
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)
                      ..scale(1 - degOneTransformAnimation.value),
                      alignment: Alignment.center,
                      child: AnimatedOpacity(
                        opacity: (1.0 - degOneTransformAnimation.value),
                        duration: Duration(milliseconds: 250),
                        child: CircularButton(
                          color: Colors.red,
                          width: 60,
                          height: 60,
                          icon: Icon(Icons.menu, color: Colors.white),
                          tooltip: 'Menu',
                          onPress: (){
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void incrementCounter(String title) {
    switch (title) {
      case 'Buena Sensacion\nBuen Tiro':
        setState(() {
          widget.trainning.shotSecuence.add('BB');
        });
        break;
      case 'Buena Sensacion\nMal Tiro':
        setState(() {
          widget.trainning.shotSecuence.add('BM');
        });
        break;
      case 'Mala Sensacion\nBuen Tiro':
        setState(() {
          widget.trainning.shotSecuence.add('MB');
        });  
        break;
      case 'Mala Sensacion\nMal Tiro':
        setState(() {
          widget.trainning.shotSecuence.add('MM');
        });
        break;
      default:
    }

    if ((widget.trainning.shotSecuence.length) > (widget.trainning.series * widget.trainning.arrowsPerEnd)){
      setState(() {
        widget.trainning.series++;
      });
    }

    setState(() {
      widget.database.trainningsDB[widget.index] = widget.trainning;
    });
    DatabaseFileRoutines().writeDataBase(databaseToJson(widget.database));
  }

  void decrementCounter(){
    setState(() {
      widget.trainning.shotSecuence.removeLast();
      widget.trainning.series = (widget.trainning.shotSecuence.length / widget.trainning.arrowsPerEnd).round();
      widget.database.trainningsDB[widget.index] = widget.trainning;
    });
    DatabaseFileRoutines().writeDataBase(databaseToJson(widget.database));
  }
}

class LevelTwoFinal extends StatefulWidget {
  LevelTwoFinal({Key? key}) : super(key: key);

  @override
  _LevelTwoFinalState createState() => _LevelTwoFinalState();
}

class _LevelTwoFinalState extends State<LevelTwoFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:<Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: 
                  Container(
                    color: Colors.amber,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        MaterialButton(
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2,
                          child: Text('Impacto en Zona',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'Buen Tiro');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      MaterialButton(
                        elevation: 0.0,
                        minWidth: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/2,
                        child: Text('No Impacto en Zona',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'Mal Tiro');
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          ]
        )
      )
    );
  }
}