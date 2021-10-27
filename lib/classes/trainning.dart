
class Trainning{
  int arrowsPerEnd;
  int series = 0;
  String technical;
  List <String> shotSecuence = [];

  Trainning({required this.arrowsPerEnd, required this.technical});

  void completeShotSecuence(){
    int i = shotSecuence.length;

    if (shotSecuence.length != (series * arrowsPerEnd)){
      shotSecuence.length = series * arrowsPerEnd;
      shotSecuence.fillRange(i, shotSecuence.length, '');
    }
  }
}