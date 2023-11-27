import 'package:my_casey/const/weekend_list.dart';

bool isKATUSAPXOpen() {
  DateTime today = DateTime.now();

  if (today.weekday == DateTime.saturday || today.weekday == DateTime.sunday) {
    return true;
  }

  for (List<int> weekendDay in WEEKEND_LIST) {
    if (today.year == weekendDay[0] && today.month == weekendDay[1] && today.day == weekendDay[2]) {
      return true;
    }
  }

  return false;
}