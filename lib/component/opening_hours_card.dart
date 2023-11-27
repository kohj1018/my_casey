import 'package:flutter/material.dart';
import 'package:my_casey/const/colors.dart';
import 'package:my_casey/screen/detail_opening_hours_screen.dart';

class OpeningHoursCard extends StatelessWidget {

  final String facilityType;
  final bool isWeekend;
  final bool isTomorrowWeekend;

  const OpeningHoursCard({
    required this.facilityType,
    required this.isWeekend,
    required this.isTomorrowWeekend,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> resultText = [];

    switch (facilityType) {
      case 'DFAC':
        resultText = (isWeekend ? [
          Text("BRUNCH : 09:30 ~ 13:00"),
          SizedBox(height: 8.0),
          Text("SUPPER : 17:00 ~ 18:30"),
        ] : [
          Text("BREAKFAST : 07:30 ~ 09:00"),
          SizedBox(height: 8.0),
          Text("LUNCH : 11:30 ~ 13:00"),
          SizedBox(height: 8.0),
          Text("DINNER : 17:00 ~ 18:30"),
        ]);
        break;
      case 'KATUSA PX':
        if (isWeekend) {
          resultText = [
            const Text(
              "CLOSED",
              style: TextStyle(color: Colors.red),
            )
          ];
        } else {
          DateTime today = DateTime.now();
          if (today.day == DateTime.friday || isTomorrowWeekend) {
            resultText = [Text("10:00 ~ 14:40")];
          } else if (today.day == DateTime.wednesday) {
            resultText = [
              Text("11:00 ~ 12:00"),
              SizedBox(height: 8.0),
              Text("17:40 ~ 20:00"),
            ];
          } else {
            resultText = [
              Text("10:00 ~ 14:40"),
              SizedBox(height: 8.0),
              Text("17:40 ~ 20:00"),
            ];
          }
        }
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailOpeningHoursScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: PRIMARY_COLOR,
          ),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PRIMARY_COLOR,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (facilityType == "KATUSA PX" ? "KATUSA\nPX" : facilityType),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 32.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: resultText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
