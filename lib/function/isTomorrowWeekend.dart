import 'package:my_casey/const/weekend_list.dart';

bool isTomorrowWeekend() {
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  if (tomorrow.weekday == DateTime.saturday || tomorrow.weekday == DateTime.sunday) {
    return true;
  }

  for (List<int> weekendDay in WEEKEND_LIST) {
    if (tomorrow.year == weekendDay[0] && tomorrow.month == weekendDay[1] && tomorrow.day == weekendDay[2]) {
      return true;
    }
  }

  return false;
}