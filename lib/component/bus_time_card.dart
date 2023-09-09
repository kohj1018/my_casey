import 'package:flutter/material.dart';
import 'package:my_casey/const/colors.dart';

class BusTimeCard extends StatelessWidget {

  final String busType;
  final String lastBusTime;
  final String nextBusTime;

  const BusTimeCard({
    required this.busType,
    required this.lastBusTime,
    required this.nextBusTime,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: PRIMARY_COLOR,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(busType),
                ),
              ),
              SizedBox(width: 32.0),
              Column(
                children: [
                  Text('$lastBusTime 출발 버스\n- 출발 후 O분 경과'),
                  SizedBox(height: 8.0),
                  Text('$nextBusTime 출발 버스\n- 출발 O분 전')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
