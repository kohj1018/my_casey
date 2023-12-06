import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_casey/component/detail_opening_hours_container.dart';
import 'package:my_casey/component/detail_opening_hours_text.dart';

class DetailOpeningHoursScreen extends StatelessWidget {

  final String facilityType;
  final int focusNum;

  const DetailOpeningHoursScreen({
    required this.facilityType,
    required this.focusNum,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> resultWidgetList = [];

    const paddingBetweenText = 8.0;
    const paddingBetweenContainer = 24.0;

    switch (facilityType) {
      case 'DFAC':
        resultWidgetList = [
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 0,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "MONDAY TO FRIDAY", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "BREAKFAST : 07:30 ~ 09:00"),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "LUNCH : 11:30 ~ 13:00"),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "DINNER : 17:00 ~ 18:30"),
              ],
          ),
          const SizedBox(height: paddingBetweenContainer),
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 1,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "WEEKENDS & HOLIDAYS", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "BRUNCH : 09:30 ~ 13:00"),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "SUPPER : 17:00 ~ 18:30"),
              ],
          ),
        ];
        break;
      case 'KATUSA PX':
        resultWidgetList = [
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 0,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "MON & TUE & THU", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "10:00 ~ 14:40"),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "17:40 ~ 20:00"),
              ],
          ),
          const SizedBox(height: paddingBetweenContainer),
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 1,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "WED", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "11:00 ~ 12:00"),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "17:40 ~ 20:00"),
              ],
          ),
          const SizedBox(height: paddingBetweenContainer),
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 2,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 2, text: "FRI & BEFORE HOLIDAY", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 2, text: "10:00 ~ 14:40"),
              ],
          ),
          const SizedBox(height: paddingBetweenContainer),
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 3,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 3, text: "WEEKEND & HOLIDAY", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 3, text: "CLOSED"),
              ],
          ),
        ];
        break;
      case 'CAC':
        resultWidgetList = [
          DetailOpeningHoursContainer(
              focusNum: focusNum,
              containerNum: 0,
              textList: [
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "MONDAY TO SATURDAY", isTitle: true),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "09:00 ~ 21:00"),
                const SizedBox(height: paddingBetweenText),
                DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "LIBRARY : 10:00 ~ 19:00"),
              ],
          ),
          const SizedBox(height: paddingBetweenContainer),
          DetailOpeningHoursContainer(
            focusNum: focusNum,
            containerNum: 1,
            textList: [
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "SUNDAY", isTitle: true),
              const SizedBox(height: paddingBetweenText),
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "10:00 ~ 19:00"),
              const SizedBox(height: paddingBetweenText),
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "LIBRARY : CLOSED"),
            ],
          ),
        ];
        break;
      case 'USO':
        resultWidgetList = [
          DetailOpeningHoursContainer(
            focusNum: focusNum,
            containerNum: 0,
            textList: [
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "MONDAY TO FRIDAY", isTitle: true),
              const SizedBox(height: paddingBetweenText),
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "09:00 ~ 18:00"),
            ],
          ),
          const SizedBox(height: paddingBetweenContainer),
          DetailOpeningHoursContainer(
            focusNum: focusNum,
            containerNum: 1,
            textList: [
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "WEEKEND", isTitle: true),
              const SizedBox(height: paddingBetweenText),
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 1, text: "10:00 ~ 17:00"),
            ],
          ),
        ];
        break;
      case 'Barber Shop':
        resultWidgetList = [
          DetailOpeningHoursContainer(
            focusNum: focusNum,
            containerNum: 0,
            textList: [
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "MONDAY TO SUNDAY", isTitle: true),
              const SizedBox(height: paddingBetweenText),
              DetailOpeningHoursText(focusNum: focusNum, containerNum: 0, text: "10:00 ~ 19:00"),
            ],
          ),
        ];
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 76.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Column(
                  children: resultWidgetList,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        'detailFacilityOpeningHours'.tr(args: [facilityType]),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
