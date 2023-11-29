import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_casey/component/opening_hours_card.dart';
import 'package:my_casey/function/isTodayWeekend.dart';
import 'package:my_casey/function/isTomorrowWeekend.dart';

class OpeningHoursScreen extends StatefulWidget {
  const OpeningHoursScreen({Key? key}) : super(key: key);

  @override
  State<OpeningHoursScreen> createState() => _OpeningHoursScreenState();
}

class _OpeningHoursScreenState extends State<OpeningHoursScreen> {
  @override
  Widget build(BuildContext context) {
    bool isWeekend = isTodayWeekend();
    bool isNextDayWeekend = isTomorrowWeekend();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'holidayOrNot'.tr(),
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: isWeekend ? 'Yes' : 'No',
                          style: TextStyle(
                              color: isWeekend ? Colors.red : Colors.black
                          ),
                        )
                      ]
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            OpeningHoursCard(
              facilityType: "DFAC",
              isWeekend: isWeekend,
              isTomorrowWeekend: isNextDayWeekend,
            ),
            const SizedBox(height: 8.0),
            OpeningHoursCard(
              facilityType: "KATUSA PX",
              isWeekend: isWeekend,
              isTomorrowWeekend: isNextDayWeekend,
            ),
            const SizedBox(height: 8.0),
            OpeningHoursCard(
              facilityType: "CAC",
              isWeekend: isWeekend,
              isTomorrowWeekend: isNextDayWeekend,
            ),
            const SizedBox(height: 8.0),
            OpeningHoursCard(
              facilityType: "USO",
              isWeekend: isWeekend,
              isTomorrowWeekend: isNextDayWeekend,
            ),
            const SizedBox(height: 8.0),
            OpeningHoursCard(
              facilityType: "Barber Shop",
              isWeekend: isWeekend,
              isTomorrowWeekend: isNextDayWeekend,
            ),
          ],
        ),
      ),
    );
  }
}
