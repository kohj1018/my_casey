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
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: isWeekend 
            ? AppColors.error.withOpacity(0.1)
            : AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isWeekend 
              ? AppColors.error.withOpacity(0.3)
              : AppColors.success.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isWeekend ? Icons.weekend_rounded : Icons.work_rounded,
            color: isWeekend ? AppColors.error : AppColors.success,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isWeekend ? 'weekend'.tr() : 'weekday'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isWeekend ? AppColors.error : AppColors.success,
              fontWeight: FontWeight.w600,
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
