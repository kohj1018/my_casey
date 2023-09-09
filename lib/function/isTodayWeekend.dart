import 'package:my_casey/const/weekend_list.dart';

bool isTodayWeekend() {
  DateTime today = DateTime.now();
  if (today.hour == 0) today = today.subtract(const Duration(days: 1)); // 24시가 지났더라도 시간표 일정은 전날을 따르므로 이를 반영

  if (today.weekday == DateTime.saturday || today.weekday == DateTime.sunday) {
    return true;
  }

  for (List<int> weekendDay in WEEKEND_LIST) {
    if (today.year == weekendDay[0] && today.month == weekendDay[1] && today.day == weekendDay[2]) {
      for (List<int> korWeekendDay in KOR_WEEKEND_LIST) { // 한국 명절 제외
        if (today.year == korWeekendDay[0] && today.month == korWeekendDay[1] && today.day == korWeekendDay[2]) {
          return false;
        }
      }
      return true;
    }
  }

  return false;
}