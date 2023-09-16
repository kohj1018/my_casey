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
            final text = DateFormat.E().format(day);

            return Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (day.weekday == DateTime.saturday) {
            final text = DateFormat.E().format(day);

            return Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.blueAccent),
              ),
            );
          }
        },

        defaultBuilder: (context, day, _) {
          DateTime yesterday = day.subtract(const Duration(days: 1));
          DateTime tomorrow = day.add(const Duration(days: 1));
          bool isYesterdayWeekend = false;
          bool isTodayWeekend = false;
          bool isTomorrowWeekend = false;
          for (List<int> weekendDay in WEEKEND_LIST) {

            if ((day.year == weekendDay[0] && day.month == weekendDay[1] && day.day == weekendDay[2]) || day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
              isTodayWeekend = true;
              return Center(
                child: Text(
                  day.day.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if ((yesterday.year == weekendDay[0] && yesterday.month == weekendDay[1] && yesterday.day == weekendDay[2]) || yesterday.weekday == DateTime.saturday || yesterday.weekday == DateTime.sunday) {
              isYesterdayWeekend = true;
            }

            if ((tomorrow.year == weekendDay[0] && tomorrow.month == weekendDay[1] && tomorrow.day == weekendDay[2]) || tomorrow.weekday == DateTime.saturday || tomorrow.weekday == DateTime.sunday) {
              isTomorrowWeekend = true;
            }
          }

          if (!isTodayWeekend && !isYesterdayWeekend && isTomorrowWeekend) {
            return Center(
              child: Text(
                day.day.toString(),
                style: const TextStyle(color: Colors.blueAccent),
              ),
            );
          }

          return null;
        },
      ),
    );
  }
}
