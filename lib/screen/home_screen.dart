import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_casey/component/bus_time_card.dart';
import 'package:my_casey/function/checkNearestBusTimes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, List<int>> h221BusInfo;
  late Map<String, List<int>> hoveyBusInfo;
  late Map<String, List<int>> tmcBusInfo;

  @override
  Widget build(BuildContext context) {
    Stream<DateTime> now = Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: now,
            builder: (context, snapshot) {
              DateTime curTime = DateTime.now();

              if (snapshot.hasData) {
                curTime = snapshot.data!;
              }

              h221BusInfo = checkNearestBusTimes('H221', false, curTime);
              hoveyBusInfo = checkNearestBusTimes('HOVEY', false, curTime);
              tmcBusInfo = checkNearestBusTimes('TMC', false, curTime);

              String modifiedCurTime = DateFormat('HH:mm').format(curTime);

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '현재시간 : $modifiedCurTime',
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 18.0),
                    Column(
                      children: [
                        BusTimeCard(
                          busType: 'H221',
                          lastBusTime: '${h221BusInfo['lastBusTime']![0].toString().padLeft(2, '0')}:${h221BusInfo['lastBusTime']![1].toString().padLeft(2, '0')}',
                          lastBusMinDiff: h221BusInfo['lastBusTime']![2],
                          nextBusTime: '${h221BusInfo['nextBusTime']![0].toString().padLeft(2, '0')}:${h221BusInfo['nextBusTime']![1].toString().padLeft(2, '0')}',
                          nextBusMinDiff: h221BusInfo['nextBusTime']![2],
                        ),
                        const SizedBox(height: 8.0),
                        BusTimeCard(
                          busType: 'HOVEY',
                          lastBusTime: '${hoveyBusInfo['lastBusTime']![0].toString().padLeft(2, '0')}:${hoveyBusInfo['lastBusTime']![1].toString().padLeft(2, '0')}',
                          lastBusMinDiff: hoveyBusInfo['lastBusTime']![2],
                          nextBusTime: '${hoveyBusInfo['nextBusTime']![0].toString().padLeft(2, '0')}:${hoveyBusInfo['nextBusTime']![1].toString().padLeft(2, '0')}',
                          nextBusMinDiff: hoveyBusInfo['nextBusTime']![2],
                        ),
                        const SizedBox(height: 8.0),
                        BusTimeCard(
                          busType: 'TMC',
                          lastBusTime: '${tmcBusInfo['lastBusTime']![0].toString().padLeft(2, '0')}:${tmcBusInfo['lastBusTime']![1].toString().padLeft(2, '0')}',
                          lastBusMinDiff: tmcBusInfo['lastBusTime']![2],
                          nextBusTime: '${tmcBusInfo['nextBusTime']![0].toString().padLeft(2, '0')}:${tmcBusInfo['nextBusTime']![1].toString().padLeft(2, '0')}',
                          nextBusMinDiff: tmcBusInfo['nextBusTime']![2],
                        ),
                      ],
                    ),
                  ]
              );
            },
          ),
        ),
      ),
    );
  }
}
