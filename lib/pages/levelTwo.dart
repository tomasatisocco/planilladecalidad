import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/pages/stats.dart';
import 'package:planilla_de_calidad/widgets/feelButton.dart';
import 'package:planilla_de_calidad/widgets/circularButton.dart';

class LevelTwoPage extends StatefulWidget {
  final Trainning trainning;

  LevelTwoPage({Key? key, required this.trainning}) : super(key: key);

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
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FeelButton(
                          color: Colors.amber,
                          title: 'Buena Sensacion\nBuen Tiro',
                          counter: widget.trainning.shotSecuence.where((element) => element == 'BB').length,
                          onChanged: incrementCounter
                        ),
                      ),
                      Expanded(
                        child: FeelButton(
                          color: Colors.redAccent,
                          title: 'Buena Sensacion\nMal Tiro',
                          counter: widget.trainning.shotSecuence.where((element) => element == 'BM').length,
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
                          counter: widget.trainning.shotSecuence.where((element) => element == 'MB').length,
                          onChanged: incrementCounter
                        ),
                      ),
                      Expanded( 
                        child: FeelButton(
                          color: Colors.black,
                          title: 'Mala Sensacion\nMal Tiro',
                          counter: widget.trainning.shotSecuence.where((element) => element == 'MM').length,
                          onChanged: incrementCounter
                        ),
                      ),
                    ],
                  ),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StatsPage(actualTrainning: widget.trainning)));
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
                            Navigator.pop(context);
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
  }

  void decrementCounter(){
    setState(() {
      widget.trainning.shotSecuence.removeLast();
      widget.trainning.series = (widget.trainning.shotSecuence.length / widget.trainning.arrowsPerEnd).round();
    });
  }
}