import 'package:easy_localization/easy_localization.dart';
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
  final bool isUpdatedTimeTable;

  const BusTimeCard({
    required this.busType,
    required this.lastBusTime,
    required this.lastBusMinDiff,
    required this.nextBusTime,
    required this.nextBusMinDiff,
    required this.isWeekend,
    required this.isUpdatedTimeTable,
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
                builder: (context) => DetailBusScheduleScreen(busType: busType, lastBusTime: lastBusTime, nextBusTime: nextBusTime, isWeekend: isWeekend, isUpdatedTimeTable: isUpdatedTimeTable),
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
                        text: 'departureBus'.tr(args: [modifiedLastBusTime]),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: '\n- ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'afterDeparture'.tr(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'min'.tr(args: [lastBusMinDiff.toString()]),
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          TextSpan(
                            text: 'lapse'.tr(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (nextBusMinDiff >= 0) RichText(
                      text: TextSpan(
                        text: 'departureBus'.tr(args: [modifiedNextBusTime]),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: '\n- ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'departure'.tr(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'min'.tr(args: [nextBusMinDiff.toString()]),
                            style: const TextStyle(
                                color: Colors.blueAccent,
                            ),
                          ),
                          TextSpan(
                            text: 'before'.tr(),
                            style: const TextStyle(
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
