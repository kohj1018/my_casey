import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_casey/const/bus_time.dart';
import 'package:my_casey/const/colors.dart';

class DetailBusScheduleScreen extends StatefulWidget {

  final String busType;
  final String lastBusTime;
  final String nextBusTime;
  final bool isWeekend;
  final bool isUpdatedTimeTable;

  const DetailBusScheduleScreen({
    required this.busType,
    required this.lastBusTime,
    required this.nextBusTime,
    required this.isWeekend,
    required this.isUpdatedTimeTable,
    Key? key
  }) : super(key: key);

  @override
  State<DetailBusScheduleScreen> createState() => _DetailBusScheduleScreenState();
}

class _DetailBusScheduleScreenState extends State<DetailBusScheduleScreen> {
  final GlobalKey _widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
      .addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          _widgetKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.5
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    late List<String> weekDayTimeTable;
    late List<String> weekendDayTimeTable;

    if (widget.isUpdatedTimeTable) {
      switch (widget.busType) {
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
    } else {
      switch (widget.busType) {
        case 'H221':
          weekDayTimeTable = OLD_H221_BUS_TIME['weekday']!;
          weekendDayTimeTable = OLD_H221_BUS_TIME['weekend']!;
          break;
        case 'HOVEY':
          weekDayTimeTable = OLD_HOVEY_BUS_TIME['weekday']!;
          weekendDayTimeTable = OLD_HOVEY_BUS_TIME['weekend']!;
          break;
        case 'TMC':
          weekDayTimeTable = OLD_TMC_BUS_TIME['weekday']!;
          weekendDayTimeTable = OLD_TMC_BUS_TIME['weekend']!;
          break;
      }
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
                        padding: const EdgeInsets.only(top: 14.0),
                        decoration: BoxDecoration(
                          color: !widget.isWeekend ? Colors.black12 : Theme.of(context).scaffoldBackgroundColor,
                          border: const Border(
                            right: BorderSide(
                              width: 0.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'weekday'.tr(),
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16.0),
                            for (String time in weekDayTimeTable) Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              color: (!widget.isWeekend && (widget.lastBusTime == time || widget.nextBusTime == time)) ? PRIMARY_COLOR.withOpacity(0.5) : Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                key: !widget.isWeekend && widget.lastBusTime == time ? _widgetKey : null,
                                time,
                                style: (!widget.isWeekend && (widget.lastBusTime == time || widget.nextBusTime == time))
                                    ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                    : const TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(top: 14.0),
                        color: widget.isWeekend ? Colors.black12 : Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Text(
                              'weekend'.tr(),
                              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12.0),
                            for (String time in weekendDayTimeTable) Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              color: (widget.isWeekend && (widget.lastBusTime == time || widget.nextBusTime == time)) ? PRIMARY_COLOR.withOpacity(0.5) : Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                key: widget.isWeekend && widget.lastBusTime == time ? _widgetKey : null,
                                time,
                                style: (widget.isWeekend && (widget.lastBusTime == time || widget.nextBusTime == time))
                                    ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                                    : const TextStyle(color: Colors.black),
                              ),
                            )
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
                decoration: const BoxDecoration(
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
                      const SizedBox(width: 16.0),
                      Text(
                        'busTimeTable'.tr(args: [widget.busType]),
                        style: const TextStyle(fontSize: 16.0),
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
