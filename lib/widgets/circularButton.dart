import 'package:flutter/material.dart';

class CricularButton extends StatelessWidget{

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onPress;

  CricularButton({required this.color, required this.width, required this.height, required this.icon, required this. onPress});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: function,),
    );
  }

  void function(){
    return onPress();
  }
}