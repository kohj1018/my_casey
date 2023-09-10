import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_casey/const/weekend_list.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime.utc(2023, 9, 1),
      lastDay: DateTime.utc(2024, 10, 31),
      focusedDay: focusedDay,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = selectedDay;
        });
      },
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay!.year
            && date.month == selectedDay!.month
            && date.day == selectedDay!.day;
      },
      calendarStyle: const CalendarStyle(
        weekendTextStyle: TextStyle(color: Colors.red),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday) {
            final text = DateFormat.E('ko').format(day);

            return Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (day.weekday == DateTime.saturday) {
            final text = DateFormat.E('ko').format(day);

            return Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.blueAccent),
              ),
            );
          }
        },

        defaultBuilder: (context, day, _) {
          // DateTime nextDay = day.add(const Duration(days: 1));
          for (List<int> weekendDay in WEEKEND_LIST) {

            if (day.year == weekendDay[0] && day.month == weekendDay[1] && day.day == weekendDay[2]) {
              return Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            // if (nextDay.year == weekendDay[0] && nextDay.month == weekendDay[1] && nextDay.day == weekendDay[2] && day.weekday != DateTime.sunday) {
            //     return Center(
            //       child: Text(
            //         day.day.toString(),
            //         style: TextStyle(color: Colors.blueAccent),
            //       ),
            //     );
            // }

          }
        },
      ),
    );
  }
}
