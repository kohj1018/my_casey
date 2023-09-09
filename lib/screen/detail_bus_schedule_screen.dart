import 'package:flutter/material.dart';
import 'package:my_casey/const/bus_time.dart';
import 'package:my_casey/const/colors.dart';

class DetailBusScheduleScreen extends StatelessWidget {

  final String busType;
  final String lastBusTime;
  final String nextBusTime;
  final bool isWeekend;

  const DetailBusScheduleScreen({
    required this.busType,
    required this.lastBusTime,
    required this.nextBusTime,
    required this.isWeekend,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<String> weekDayTimeTable;
    late List<String> weekendDayTimeTable;

    switch (busType) {
      case 'H221':
        weekDayTimeTable = H221_BUS_TIME['weekday']!;
        weekendDayTimeTable = H221_BUS_TIME['weekend']!;
        break;
      case 'HOVEY':
        weekDayTimeTable = HOVEY_BUS_TIME['weekday']!;
        weekendDayTimeTable = HOVEY_BUS_TIME['weekend']!;
        break;
      case 'TMC':
        weekDayTimeTable = TMC_BUS_TIME['weekday']!;
        weekendDayTimeTable = TMC_BUS_TIME['weekend']!;
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 76.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isWeekend ? Colors.black12 : Theme.of(context).scaffoldBackgroundColor,
                          border: Border(
                            right: BorderSide(
                              width: 0.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '평일',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.0),
                            for (String time in weekDayTimeTable) Stack(
                                children: [
                                  Text(
                                    '$time\n',
                                    style: !isWeekend && (lastBusTime == time || nextBusTime == time)
                                        ? TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold)
                                        : TextStyle(color: Colors.black)
                                  ),
                                  SizedBox(height: 8.0),
                                ]
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: isWeekend ? Colors.black12 : Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Text(
                              '휴일',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.0),
                            for (String time in weekendDayTimeTable) Stack(
                                children: [
                                  Text(
                                    '$time\n',
                                    style: isWeekend && (lastBusTime == time || nextBusTime == time)
                                        ? TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold)
                                        : TextStyle(color: Colors.black)
                                  ),
                                  SizedBox(height: 8.0),
                                ]
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        '$busType 버스 시간표',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
