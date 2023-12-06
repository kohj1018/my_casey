import 'package:flutter/material.dart';

class DetailOpeningHoursText extends StatelessWidget {

  final int focusNum;
  final int containerNum;
  final String text;
  final bool isTitle;

  const DetailOpeningHoursText({
    required this.focusNum,
    required this.containerNum,
    required this.text,
    this.isTitle = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: focusNum == containerNum
          ? TextStyle(
              color: Colors.white,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
              fontSize: isTitle ? 24.0 : 14.0,
            )
          : TextStyle(
              color: Colors.black,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
              fontSize: isTitle ? 24.0 : 14.0,
            ),
    );
  }
}
