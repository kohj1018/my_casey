import 'package:intl/intl.dart';
import 'package:my_casey/const/bus_time.dart';

Map<String, List<int>> checkNearestBusTimes(String busType, bool isWeekend, DateTime now) {
  List<int> curTime = DateFormat('HH:mm').format(now).split(':').map((t) => int.parse(t)).toList();
  if (curTime[0] == 0) curTime[0] = 24; // 현재 시간이 0시면 24시로 format 변경

  // 버스 종류, 평일 구분에 따라 버스 시간표 선택
  late List<String> selectedBusTime;
  switch (busType) {
    case 'H221':
      if (!isWeekend) {
        selectedBusTime = H221_BUS_TIME['weekday']!;
      } else {
        selectedBusTime = H221_BUS_TIME['weekend']!;
      }
      break;
    case 'HOVEY':
      if (!isWeekend) {
        selectedBusTime = HOVEY_BUS_TIME['weekday']!;
      } else {
        selectedBusTime = HOVEY_BUS_TIME['weekend']!;
      }
      break;
    case 'TMC':
      if (!isWeekend) {
        selectedBusTime = TMC_BUS_TIME['weekday']!;
      } else {
        selectedBusTime = TMC_BUS_TIME['weekend']!;
      }
      break;
  }

  // String 형태의 시각을 List<int>로 가공
  final List<List<int>> timeTable = selectedBusTime.map((time) => time.split(':').map((t) =>int.parse(t)).toList()).toList();

  // 현재 시각에 가장 근접한 버스 시각 찾기
  List<int> lastBusTime = [0, 0];
  List<int> nextBusTime = [25, 0];

  timeTable.forEach((time) => {
    if (time[0] < curTime[0]) {
      lastBusTime = time
    } else if (time[0] == curTime[0]) {
      if (time[1] <= curTime[1]) {
        lastBusTime = time
      } else {
        if (time[0] < nextBusTime[0] || (time[0] == nextBusTime[0] && time[1] < nextBusTime[1])) {
          nextBusTime = time
        }
      }
    } else {  // time[0] > curTime[0]
      if (time[0] < nextBusTime[0] || (time[0] == nextBusTime[0] && time[1] < nextBusTime[1])) {
        nextBusTime = time
      }
    }
  });

  // 현재 시각에 가장 근접한 버스 시각과 현재 시각 차이 계산
  late int lastBusMinDiff;
  late int nextBusMinDiff;

  if (lastBusTime[0] == 0) {
    lastBusMinDiff = -1;
  } else if (lastBusTime[0] < curTime[0]) {
    lastBusMinDiff = (60 - lastBusTime[1]) + curTime[1];
  } else {  // lastBusTime[0] == curTime[0]
    lastBusMinDiff = curTime[1] - lastBusTime[1];
  }

  if (nextBusTime[0] == 25) {
    nextBusMinDiff = -1;
  } else if (nextBusTime[0] > curTime[0]) {
    if (nextBusTime[0] - curTime[0] == 1) {
      nextBusMinDiff = (60 - curTime[1]) + nextBusTime[1];
    } else {  // nextBusTime[0] - curTime[0] > 1
      nextBusMinDiff = (60 - curTime[1]) + (nextBusTime[0] - curTime[0] - 1) * 60;
    }
  } else {  // nextBusTime[0] == curTime[0]
    nextBusMinDiff = nextBusTime[1] - curTime[1];
  }

  // 계산한 차이 값을 리스트 맨 뒤에 넣기
  lastBusTime.add(lastBusMinDiff);
  nextBusTime.add(nextBusMinDiff);

  return {
    'lastBusTime': lastBusTime,
    'nextBusTime': nextBusTime
  };
}