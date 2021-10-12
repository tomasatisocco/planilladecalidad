import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget{

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onPress;
  final String? tooltip;

  CircularButton({required this.color, required this.width, required this.height, required this.icon, required this. onPress, this.tooltip});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(
        icon: icon, 
        enableFeedback: true, 
        onPressed: function, 
        tooltip: tooltip ?? ''),
    );
  }

  void function(){
    return onPress();
  }
}