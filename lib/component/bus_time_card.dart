import 'package:flutter/material.dart';
import 'package:my_casey/const/colors.dart';
import 'package:my_casey/screen/detail_bus_schedule_screen.dart';

class BusTimeCard extends StatelessWidget {

  final String busType;
  final String lastBusTime;
  final int lastBusMinDiff;
  final String nextBusTime;
  final int nextBusMinDiff;
  final bool isWeekend;

  const BusTimeCard({
    required this.busType,
    required this.lastBusTime,
    required this.lastBusMinDiff,
    required this.nextBusTime,
    required this.nextBusMinDiff,
    required this.isWeekend,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String modifiedLastBusTime = lastBusTime;
    String modifiedNextBusTime = nextBusTime;
    if (lastBusTime.substring(0, 2) == '24') modifiedLastBusTime.replaceAll('24', '00');
    if (nextBusTime.substring(0, 2) == '24') modifiedNextBusTime.replaceAll('24', '00');

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBusScheduleScreen(busType: busType, lastBusTime: lastBusTime, nextBusTime: nextBusTime, isWeekend: isWeekend),
            ),
        );
      },
      child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (lastBusMinDiff >= 0) RichText(
                      text: TextSpan(
                        text: '$modifiedLastBusTime 출발 버스\n- 출발 후 ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '$lastBusMinDiff분',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const TextSpan(
                            text: ' 경과',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]
                      ),
                    ),
                    SizedBox(height: 8.0),
                    if (nextBusMinDiff >= 0) RichText(
                      text: TextSpan(
                        text: '$modifiedNextBusTime 출발 버스\n- 출발 ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '$nextBusMinDiff분',
                            style: const TextStyle(
                                color: Colors.blueAccent,
                            ),
                          ),
                          const TextSpan(
                            text: ' 전',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
