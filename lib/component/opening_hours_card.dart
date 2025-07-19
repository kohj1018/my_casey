import 'package:flutter/material.dart';
import 'package:my_casey/screen/detail_opening_hours_screen.dart';
import 'package:my_casey/theme/app_theme.dart';

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

  IconData _getFacilityIcon() {
    switch (facilityType) {
      case 'DFAC':
        return Icons.restaurant_rounded;
      case 'KATUSA PX':
        return Icons.store_rounded;
      case 'CAC':
        return Icons.local_library_rounded;
      case 'USO':
        return Icons.people_rounded;
      case 'Barber Shop':
        return Icons.content_cut_rounded;
      default:
        return Icons.business_rounded;
    }
  }

  Color _getFacilityColor() {
    switch (facilityType) {
      case 'DFAC':
        return AppColors.accentOrange;
      case 'KATUSA PX':
        return AppColors.primary;
      case 'CAC':
        return AppColors.secondary;
      case 'USO':
        return AppColors.primaryLight;
      case 'Barber Shop':
        return AppColors.info;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> resultText = [];
    String name = facilityType;
    int focusNum = 0;
    bool isClosed = false;

    DateTime today = DateTime.now();

    switch (facilityType) {
      case 'DFAC':
        if (!isWeekend) {
          focusNum = 0;
          resultText = [
            _buildTimeItem("BREAKFAST", "07:30 ~ 09:00", Icons.free_breakfast_rounded),
            const SizedBox(height: 8.0),
            _buildTimeItem("LUNCH", "11:30 ~ 13:00", Icons.lunch_dining_rounded),
            const SizedBox(height: 8.0),
            _buildTimeItem("DINNER", "17:00 ~ 18:30", Icons.dinner_dining_rounded),
          ];
        } else{
          focusNum = 1;
          resultText = [
            _buildTimeItem("BRUNCH", "09:30 ~ 13:00", Icons.brunch_dining_rounded),
            const SizedBox(height: 8.0),
            _buildTimeItem("SUPPER", "17:00 ~ 18:30", Icons.dinner_dining_rounded),
          ];
        }
        break;
      case 'KATUSA PX':
        name = "KATUSA PX";
        if (isWeekend) {
          focusNum = 3;
          isClosed = true;
          resultText = [
            _buildClosedStatus()
          ];
        } else {
          if (today.weekday == DateTime.friday || isTomorrowWeekend) {
            focusNum = 2;
            resultText = [
              _buildTimeItem("OPEN", "10:00 ~ 14:40", Icons.access_time_rounded)
            ];
          } else if (today.weekday == DateTime.wednesday) {
            focusNum = 1;
            resultText = [
              _buildTimeItem("MORNING", "11:00 ~ 12:00", Icons.access_time_rounded),
              const SizedBox(height: 8.0),
              _buildTimeItem("EVENING", "17:40 ~ 20:00", Icons.access_time_rounded),
            ];
          } else {
            focusNum = 0;
            resultText = [
              _buildTimeItem("MORNING", "10:00 ~ 14:40", Icons.access_time_rounded),
              const SizedBox(height: 8.0),
              _buildTimeItem("EVENING", "17:40 ~ 20:00", Icons.access_time_rounded),
            ];
          }
        }
        break;
      case 'CAC':
        if (today.weekday == DateTime.sunday) {
          focusNum = 1;
          resultText = [
            _buildTimeItem("CAC", "10:00 ~ 19:00", Icons.business_rounded),
            const SizedBox(height: 8.0),
            _buildClosedItem("LIBRARY", Icons.local_library_rounded),
          ];
        } else {
          focusNum = 0;
          resultText = [
            _buildTimeItem("CAC", "09:00 ~ 21:00", Icons.business_rounded),
            const SizedBox(height: 8.0),
            _buildTimeItem("LIBRARY", "10:00 ~ 19:00", Icons.local_library_rounded),
          ];
        }
        break;
      case 'USO':
        if (today.weekday == DateTime.saturday || today.weekday == DateTime.sunday) {
          focusNum = 1;
          resultText = [
            _buildTimeItem("WEEKEND", "10:00 ~ 17:00", Icons.access_time_rounded)
          ];
        } else {
          focusNum = 0;
          resultText = [
            _buildTimeItem("WEEKDAY", "09:00 ~ 18:00", Icons.access_time_rounded)
          ];
        }
        break;
      case 'Barber Shop':
        name = "Barber Shop";
        focusNum = 0;
        resultText = [
          _buildTimeItem("OPEN", "10:00 ~ 19:00", Icons.access_time_rounded)
        ];
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailOpeningHoursScreen(
              facilityType: facilityType,
              focusNum: focusNum,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: isClosed 
                ? AppColors.error.withOpacity(0.2)
                : _getFacilityColor().withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // 아이콘 영역
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isClosed 
                        ? [AppColors.error.withOpacity(0.1), AppColors.error.withOpacity(0.05)]
                        : [_getFacilityColor().withOpacity(0.15), _getFacilityColor().withOpacity(0.05)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isClosed ? AppColors.error.withOpacity(0.3) : _getFacilityColor().withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  _getFacilityIcon(),
                  color: isClosed ? AppColors.error : _getFacilityColor(),
                  size: 28,
                ),
              ),
              
              const SizedBox(width: 20.0),
              
              // 정보 영역
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...resultText,
                  ],
                ),
              ),
              
              // 화살표 아이콘
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeItem(String label, String time, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              children: [
                TextSpan(text: "$label : "),
                TextSpan(
                  text: time,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClosedStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.do_not_disturb_rounded,
            size: 16,
            color: AppColors.error,
          ),
          const SizedBox(width: 6),
          Text(
            "CLOSED",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClosedItem(String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.error,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              children: [
                TextSpan(text: "$label : "),
                TextSpan(
                  text: "CLOSED",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
