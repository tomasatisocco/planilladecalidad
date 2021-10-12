import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:planilla_de_calidad/widgets/feelButton.dart';
import 'package:planilla_de_calidad/widgets/circularButton.dart';

class LevelTwoPage extends StatefulWidget {
  LevelTwoPage({Key? key}) : super(key: key);

  @override
  _LevelTwoPageState createState() => _LevelTwoPageState();
}

class _LevelTwoPageState extends State<LevelTwoPage> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation degOneTransformAnimation;
  late Animation rotationAnimation;
  
  Trainning _trainning = Trainning(arrowsPerEnd: 6, technical: 'Transferencia');

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
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
            Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(-300.0 * degOneTransformAnimation.value, 0.0),
                    child: Transform(
                      transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)..scale(degOneTransformAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.lightBlueAccent,
                        width: 50,
                        height: 50,
                        icon: Icon(Icons.menu, color: Colors.white), 
                        onPress: (){},
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-200.0 * degOneTransformAnimation.value, 0.0),
                    child: Transform(
                      transform: Matrix4.rotationZ(rotationAnimation.value / 57.29)..scale(degOneTransformAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.blueGrey,
                        width: 50,
                        height: 50,
                        icon: Icon(Icons.menu, color: Colors.white), 
                        onPress: (){},
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
                        icon: Icon(Icons.menu, color: Colors.white), 
                        onPress: (){},
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(rotationAnimation.value / 57.29),
                      alignment: Alignment.center,
                    child: CircularButton(
                      color: Colors.red,
                      width: 60,
                      height: 60,
                      icon: Icon(Icons.menu, color: Colors.white), 
                      onPress: (){
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      },
                    ),
                  ),
                ],
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