import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';

// ignore: must_be_immutable
class StatsPage extends StatelessWidget {

  final Trainning trainning;

  late List<String> _mediasPerEnd = List.generate(((trainning.shotSecuence.length) / trainning.arrowsPerEnd).round(), 
    (index) =>
      ((trainning.shotSecuence.sublist(
        index * trainning.arrowsPerEnd,
        (index * trainning.arrowsPerEnd) + trainning.arrowsPerEnd)
        .where((element) => element == 'BB' || element == 'B').length / trainning.arrowsPerEnd)*100).toStringAsFixed(1) + '%'
  );

  StatsPage({Key? key, required this.trainning,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadisticas'),
        centerTitle: true,
        leading: BackButton(
          onPressed: (){
            trainning.removeBlanks();
            Navigator.pop(context);
          }  
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Hola'),
            Text('Fecha: ${trainning.date.toString().substring(0,10)}'),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ((trainning.shotSecuence.length / trainning.arrowsPerEnd).round()),
                itemBuilder:(context, index1) => SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Text('${index1 + 1}'),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                       shrinkWrap: true,
                        itemCount: trainning.arrowsPerEnd,
                        itemBuilder: (context, index) => 
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: trainning.shotColor(trainning.shotSecuence[index1 * trainning.arrowsPerEnd + index]),
                            ),
                            child: Text(trainning.shotSecuence[index1 * trainning.arrowsPerEnd + index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                     Text(_mediasPerEnd[index1]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}