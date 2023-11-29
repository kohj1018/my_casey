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
    String name = facilityType;

    DateTime today = DateTime.now();

    switch (facilityType) {
      case 'DFAC':
        if (isWeekend) {
          resultText = [
            Text("BRUNCH : 09:30 ~ 13:00"),
            SizedBox(height: 8.0),
            Text("SUPPER : 17:00 ~ 18:30"),
          ];
        } else{
          resultText = [
            Text("BREAKFAST : 07:30 ~ 09:00"),
            SizedBox(height: 8.0),
            Text("LUNCH : 11:30 ~ 13:00"),
            SizedBox(height: 8.0),
            Text("DINNER : 17:00 ~ 18:30"),
          ];
        }
        break;
      case 'KATUSA PX':
        name = "KATUSA\nPX";
        if (isWeekend) {
          resultText = [
            const Text(
              "CLOSED",
              style: TextStyle(color: Colors.red),
            )
          ];
        } else {
          if (today.day == DateTime.friday || isTomorrowWeekend) {
            resultText = [
              Text("10:00 ~ 14:40")
            ];
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
      case 'Barber Shop':
        name = "Barber\nShop";
        resultText = [
          Text("10:00 ~ 19:00")
        ];
        break;
      case 'CAC':
        if (today.day == DateTime.sunday) {
          resultText = [
            Text("10:00 ~ 19:00"),
            SizedBox(height: 8.0),
            Text("LIBRARY : CLOSED"),
          ];
        } else {
          resultText = [
            Text("09:00 ~ 21:00"),
            SizedBox(height: 8.0),
            Text("LIBRARY : 10:00 ~ 19:00"),
          ];
        }
        break;
      case 'USO':
        if (today.day == DateTime.saturday || today.day == DateTime.sunday) {
          resultText = [
            Text("09:00 ~ 18:00")
          ];
        } else {
          resultText = [
            Text("10:00 ~ 17:00")
          ];
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
                      name,
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
