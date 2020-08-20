import 'package:flutter/cupertino.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    Key key,
    @required this.size,
    @required this.text,
    @required this.textColor,
    @required this.textSize,
    this.margin: 2.0,
  }) : super(key: key);

  final double size;
  final String text;
  final Color textColor;
  final double textSize;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: size,
        width: size,
        child: Text(
          text,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
        margin: EdgeInsets.all(margin));
  }
}
