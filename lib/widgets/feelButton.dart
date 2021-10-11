import 'package:flutter/material.dart';

class FeelButton extends StatelessWidget {
  final Color color;
  final String title;
  final int counter;
  final onChanged;

  const FeelButton(
      {Key? key,
      required this.color,
      required this.counter,
      required this.title,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          MaterialButton(
            elevation: 0.0,
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Text('$counter',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
            ),
            onPressed: () {
              _onChanged();
            },
          ),
        ],
      ),
    );    
  }

  _onChanged() {
    onChanged(title);
  }
}