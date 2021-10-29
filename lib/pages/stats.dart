import 'package:flutter/material.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';

// ignore: must_be_immutable
class StatsPage extends StatelessWidget {

  final Trainning actualTrainning;

  late List<String> _mediasPerEnd = List.generate(((actualTrainning.shotSecuence.length) / actualTrainning.arrowsPerEnd).round(), 
    (index) =>
      ((actualTrainning.shotSecuence.sublist(
        index * actualTrainning.arrowsPerEnd,
        (index * actualTrainning.arrowsPerEnd) + actualTrainning.arrowsPerEnd)
        .where((element) => element == 'BB' || element == 'B').length / actualTrainning.arrowsPerEnd)*100).toStringAsFixed(1) + '%'
  );

  StatsPage({Key? key, required this.actualTrainning,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadisticas'),
        centerTitle: true,
        leading: BackButton(
          onPressed: (){
            actualTrainning.removeBlanks();
            Navigator.pop(context);
          }  
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Hola'),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                //shrinkWrap: true,
                itemCount: ((actualTrainning.shotSecuence.length / actualTrainning.arrowsPerEnd).round()),
                itemBuilder:(context, index1) => SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Text('${index1 + 1}'),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                       shrinkWrap: true,
                        itemCount: actualTrainning.arrowsPerEnd,
                        itemBuilder: (context, index) => 
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: actualTrainning.shotColor(actualTrainning.shotSecuence[index1 * actualTrainning.arrowsPerEnd + index]),
                            ),
                            child: Text(actualTrainning.shotSecuence[index1 * actualTrainning.arrowsPerEnd + index],
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