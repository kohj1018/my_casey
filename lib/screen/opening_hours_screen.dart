import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_casey/component/opening_hours_card.dart';
import 'package:my_casey/function/isTodayWeekend.dart';
import 'package:my_casey/function/isTomorrowWeekend.dart';
import 'package:my_casey/theme/app_theme.dart';

class OpeningHoursScreen extends StatefulWidget {
  const OpeningHoursScreen({Key? key}) : super(key: key);

  @override
  State<OpeningHoursScreen> createState() => _OpeningHoursScreenState();
}

class _OpeningHoursScreenState extends State<OpeningHoursScreen> {
  Widget _buildStatusHeader(bool isWeekend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isWeekend 
              ? [AppColors.error.withOpacity(0.1), AppColors.error.withOpacity(0.05)]
              : [AppColors.success.withOpacity(0.1), AppColors.success.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isWeekend 
              ? AppColors.error.withOpacity(0.2)
              : AppColors.success.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isWeekend ? AppColors.error : AppColors.success,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isWeekend ? Icons.weekend_rounded : Icons.work_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'holidayOrNot'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isWeekend ? 'Holiday Schedule' : 'Weekday Schedule',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isWeekend ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isWeekend ? AppColors.error : AppColors.success,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isWeekend ? 'Yes' : 'No',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isWeekend = isTodayWeekend();
    bool isNextDayWeekend = isTomorrowWeekend();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusHeader(isWeekend),
          
          OpeningHoursCard(
            facilityType: "DFAC",
            isWeekend: isWeekend,
            isTomorrowWeekend: isNextDayWeekend,
          ),
          const SizedBox(height: 12.0),
          OpeningHoursCard(
            facilityType: "KATUSA PX",
            isWeekend: isWeekend,
            isTomorrowWeekend: isNextDayWeekend,
          ),
          const SizedBox(height: 12.0),
          OpeningHoursCard(
            facilityType: "CAC",
            isWeekend: isWeekend,
            isTomorrowWeekend: isNextDayWeekend,
          ),
          const SizedBox(height: 12.0),
          OpeningHoursCard(
            facilityType: "USO",
            isWeekend: isWeekend,
            isTomorrowWeekend: isNextDayWeekend,
          ),
          const SizedBox(height: 12.0),
          OpeningHoursCard(
            facilityType: "Barber Shop",
            isWeekend: isWeekend,
            isTomorrowWeekend: isNextDayWeekend,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
