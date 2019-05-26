import 'package:flutter/material.dart';

class MonthLabel extends StatelessWidget {

  const MonthLabel({
    Key key,
    @required this.size,
    this.text: "",
    @required this.textColor,
  }) : super(key: key);

  final double size;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: size,
      width: size,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            width: 60,
            bottom: 0,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor
              ),
            ),
          )
        ],
      ),
    );
  }
}
