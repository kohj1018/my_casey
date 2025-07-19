import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_casey/component/bus_time_card.dart';
import 'package:my_casey/function/checkNearestBusTimes.dart';
import 'package:my_casey/function/isTodayWeekend.dart';
import 'package:my_casey/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusScheduleScreen extends StatefulWidget {
  const BusScheduleScreen({Key? key}) : super(key: key);

  @override
  State<BusScheduleScreen> createState() => _BusScheduleScreenState();
}

class _BusScheduleScreenState extends State<BusScheduleScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isUpdatedTimeTable;

  late Map<String, List<int>> h221BusInfo;
  late Map<String, List<int>> hoveyBusInfo;
  late Map<String, List<int>> tmcBusInfo;

  @override
  void initState() {
    super.initState();
    _isUpdatedTimeTable = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('isUpdatedTimeTable') ?? true;  // 기본값을 true로 유지
    });
  }

  Widget _buildInfoHeader(String formattedTime, bool isWeekend) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 시간 정보
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                formattedTime,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          // 휴일 정보
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isWeekend 
                  ? AppColors.error.withOpacity(0.1)
                  : AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isWeekend ? Icons.weekend_rounded : Icons.work_rounded,
                  size: 10,
                  color: isWeekend ? AppColors.error : AppColors.success,
                ),
                const SizedBox(width: 3),
                Text(
                  isWeekend ? 'Holiday' : 'Weekday',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isWeekend ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeTableToggle(bool isUpdatedTimeTable) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.update_rounded,
            color: AppColors.primary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tr('viewLatestTimetable'),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isUpdatedTimeTable,
              onChanged: (value) async {
                SharedPreferences prefs = await _prefs;
                await prefs.setBool('isUpdatedTimeTable', value);
                setState(() {
                  _isUpdatedTimeTable = _prefs.then((SharedPreferences prefs) {
                    return prefs.getBool('isUpdatedTimeTable') ?? true;
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<DateTime> now = Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
    bool isWeekend = isTodayWeekend();

    return FutureBuilder<bool>(
      future: _isUpdatedTimeTable,
      builder: (BuildContext context, AsyncSnapshot<bool> isUpdatedTimeTableSnapshot) {
        switch (isUpdatedTimeTableSnapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (isUpdatedTimeTableSnapshot.hasError) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Error: ${isUpdatedTimeTableSnapshot.error}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              );
            } else {
              bool isUpdatedTimeTable = isUpdatedTimeTableSnapshot.data!;

              return StreamBuilder(
                stream: now,
                builder: (context, snapshot) {
                  DateTime curTime = DateTime.now();

                  if (snapshot.hasData) {
                    curTime = snapshot.data!;
                  }

                  h221BusInfo = checkNearestBusTimes('H221', isWeekend, curTime, isUpdatedTimeTable);
                  hoveyBusInfo = checkNearestBusTimes('HOVEY', isWeekend, curTime, isUpdatedTimeTable);
                  tmcBusInfo = checkNearestBusTimes('TMC', isWeekend, curTime, isUpdatedTimeTable);

                  String modifiedCurTime = DateFormat('HH:mm').format(curTime);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildInfoHeader(modifiedCurTime, isWeekend),
                      
                      // 버스 카드들
                      BusTimeCard(
                        busType: 'H221',
                        lastBusTime: '${h221BusInfo['lastBusTime']![0].toString().padLeft(2, '0')}:${h221BusInfo['lastBusTime']![1].toString().padLeft(2, '0')}',
                        lastBusMinDiff: h221BusInfo['lastBusTime']![2],
                        nextBusTime: '${h221BusInfo['nextBusTime']![0].toString().padLeft(2, '0')}:${h221BusInfo['nextBusTime']![1].toString().padLeft(2, '0')}',
                        nextBusMinDiff: h221BusInfo['nextBusTime']![2],
                        isWeekend: isWeekend,
                        isUpdatedTimeTable: isUpdatedTimeTable,
                      ),
                      const SizedBox(height: 6.0),
                      BusTimeCard(
                        busType: 'HOVEY',
                        lastBusTime: '${hoveyBusInfo['lastBusTime']![0].toString().padLeft(2, '0')}:${hoveyBusInfo['lastBusTime']![1].toString().padLeft(2, '0')}',
                        lastBusMinDiff: hoveyBusInfo['lastBusTime']![2],
                        nextBusTime: '${hoveyBusInfo['nextBusTime']![0].toString().padLeft(2, '0')}:${hoveyBusInfo['nextBusTime']![1].toString().padLeft(2, '0')}',
                        nextBusMinDiff: hoveyBusInfo['nextBusTime']![2],
                        isWeekend: isWeekend,
                        isUpdatedTimeTable: isUpdatedTimeTable,
                      ),
                      const SizedBox(height: 6.0),
                      BusTimeCard(
                        busType: 'TMC',
                        lastBusTime: '${tmcBusInfo['lastBusTime']![0].toString().padLeft(2, '0')}:${tmcBusInfo['lastBusTime']![1].toString().padLeft(2, '0')}',
                        lastBusMinDiff: tmcBusInfo['lastBusTime']![2],
                        nextBusTime: '${tmcBusInfo['nextBusTime']![0].toString().padLeft(2, '0')}:${tmcBusInfo['nextBusTime']![1].toString().padLeft(2, '0')}',
                        nextBusMinDiff: tmcBusInfo['nextBusTime']![2],
                        isWeekend: isWeekend,
                        isUpdatedTimeTable: isUpdatedTimeTable,
                      ),
                      
                      const SizedBox(height: 10.0),
                      _buildTimeTableToggle(isUpdatedTimeTable),
                    ],
                  );
                },
              );
            }
        }
      },
    );
  }
}
