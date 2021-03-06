import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planilla_de_calidad/classes/trainning.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsPage extends StatelessWidget {
  final Trainning trainning;


  StatsPage({Key? key, required this.trainning,}) : super(key: key);
  late final List<String> _mediasPerEnd = List.generate(((trainning.shotSecuence.length) / trainning.arrowsPerEnd).round(), 
    (index) =>
      ((trainning.shotSecuence.sublist(
        index * trainning.arrowsPerEnd,
        (index * trainning.arrowsPerEnd) + trainning.arrowsPerEnd)
        .where((element) => element == 'BB' || element == 'B').length / trainning.arrowsPerEnd)*100).toStringAsFixed(1) + '%'
  );

  late final List<ShotsData> _shotsDataList = [
    if(trainning.shotSecuence.contains('B')) ShotsData(shotQuantity: trainning.shotSecuence.where((element) => element == 'B').length,shotType: 'B',color: Colors.green),
    if(trainning.shotSecuence.contains('M')) ShotsData(shotQuantity: trainning.shotSecuence.where((element) => element == 'M').length,shotType: 'M', color: Colors.red),
    if(trainning.shotSecuence.contains('BM')) ShotsData(shotQuantity: trainning.shotSecuence.where((element) => element == 'BM').length,shotType: 'BM', color: Colors.red),
    if(trainning.shotSecuence.contains('BB')) ShotsData(shotQuantity: trainning.shotSecuence.where((element) => element == 'BB').length,shotType: 'BB', color: Colors.amber),
    if(trainning.shotSecuence.contains('MB')) ShotsData(shotQuantity: trainning.shotSecuence.where((element) => element == 'MB').length,shotType: 'MB', color: Colors.blue),
    if(trainning.shotSecuence.contains('MM')) ShotsData(shotQuantity: trainning.shotSecuence.where((element) => element == 'MM').length,shotType: 'MM', color: Colors.black),
  ];

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
        child: SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.2,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: true,
          parallaxOffset: 0.2,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              SizedBox(height: 100,),

              SfCircularChart(
                title: ChartTitle(
                  text: 'Aspecto: ${trainning.technical}\n Acierto: ${trainning.trainningProm}',
                  textStyle: TextStyle(color: Colors.blue.shade700, fontSize: 20, fontWeight: FontWeight.bold)
                ),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Container(
                      child: Text ('BB\n ${trainning.trainningProm}', textAlign: TextAlign.center,),
                    ),
                  ),
                ],
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                tooltipBehavior: TooltipBehavior(enable: true),
                palette: List.generate(_shotsDataList.length, (index) => _shotsDataList[index].color),
                series: <CircularSeries>[
                  DoughnutSeries<ShotsData, String>(
                    dataSource: _shotsDataList,
                    xValueMapper: (ShotsData data, _) => data.shotType,
                    yValueMapper: (ShotsData data, _) => data.shotQuantity,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    explode: true,
                    explodeIndex: 1,
                  ),
                ],
              ),

              Text('Fecha: ${DateFormat.yMd().format(DateTime.parse(trainning.date))}'),
              Text('Cantidad de Tiros: ${trainning.shotSecuence.length}'),

            ]),
            panelBuilder: (controller){
              return ListView.builder(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: ((trainning.shotSecuence.length / trainning.arrowsPerEnd).round()),
                  itemBuilder:(context, index1) => SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${index1 + 1}'),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: trainning.arrowsPerEnd,
                          itemBuilder: (context, index) {
                            if (trainning.arrowsPerEnd < 9){
                              return Container(
                              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height,minHeight: 0.0,maxWidth: MediaQuery.of(context).size.width/(trainning.arrowsPerEnd + 5),minWidth: 0.0),
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
                            );
                            } else {
                              return Container(
                              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height,minHeight: 0.0,maxWidth: MediaQuery.of(context).size.width/((trainning.arrowsPerEnd - 4) * 2),minWidth: 0.0),
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: trainning.shotColor(trainning.shotSecuence[index1 * trainning.arrowsPerEnd + index]),
                              ),
                            );
                            }
                          },
                        ),
                       Text(_mediasPerEnd[index1]),
                      ],
                    ),
                  ),
              );
            },
          ),
      ),
    );
  }
}

class ShotsData{
  String shotType;
  int shotQuantity;
  Color color;

  ShotsData({required this.shotQuantity, required this.shotType, required this.color});
}