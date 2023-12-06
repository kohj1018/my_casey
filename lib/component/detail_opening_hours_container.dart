import 'package:flutter/material.dart';
import 'package:my_casey/const/colors.dart';

class DetailOpeningHoursContainer extends StatelessWidget {

  final int focusNum;
  final int containerNum;
  final List<Widget> textList;

  const DetailOpeningHoursContainer({
    required this.focusNum,
    required this.containerNum,
    required this.textList,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      color: focusNum == containerNum ? PRIMARY_COLOR.withOpacity(0.5) : Colors.transparent,
      alignment: Alignment.center,
      child: Column(
        children: textList,
      ),
    );
  }
}
