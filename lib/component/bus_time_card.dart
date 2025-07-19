import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_casey/screen/detail_bus_schedule_screen.dart';
import 'package:my_casey/theme/app_theme.dart';

class BusTimeCard extends StatelessWidget {
  final String busType;
  final String lastBusTime;
  final int lastBusMinDiff;
  final String nextBusTime;
  final int nextBusMinDiff;
  final bool isWeekend;
  final bool isUpdatedTimeTable;

  const BusTimeCard({
    required this.busType,
    required this.lastBusTime,
    required this.lastBusMinDiff,
    required this.nextBusTime,
    required this.nextBusMinDiff,
    required this.isWeekend,
    required this.isUpdatedTimeTable,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String modifiedNextBusTime = nextBusTime.startsWith('24') ? nextBusTime.replaceFirst('24', '00') : nextBusTime;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBusScheduleScreen(
              busType: busType,
              lastBusTime: lastBusTime,
              nextBusTime: nextBusTime,
              isWeekend: isWeekend,
              isUpdatedTimeTable: isUpdatedTimeTable,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          gradient: _getGradient(),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: _getTimeColor().withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              _buildBusTypeSection(),
              const SizedBox(width: 20.0),
              Expanded(child: _buildTimeSection()),
              _buildNextBusSection(modifiedNextBusTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusTypeSection() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Center(
        child: Text(
          busType,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSection() {
    if (nextBusMinDiff < 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '운행 종료',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'lastBus'.tr(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$nextBusMinDiff',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '분 후',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildProgressBar(),
      ],
    );
  }

  Widget _buildNextBusSection(String modifiedNextBusTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(
          Icons.schedule,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          modifiedNextBusTime,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'departure'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    if (nextBusMinDiff < 0) return const SizedBox();
    
    double progress;
    if (nextBusMinDiff <= 5) {
      progress = (5 - nextBusMinDiff) / 5;
    } else if (nextBusMinDiff <= 15) {
      progress = (15 - nextBusMinDiff) / 15;
    } else {
      progress = 0.1;
    }

    return Container(
      height: 6,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 120 * progress,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  LinearGradient _getGradient() {
    Color color = _getTimeColor();
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color,
        color.withOpacity(0.8),
      ],
    );
  }

  Color _getTimeColor() {
    if (nextBusMinDiff < 0) {
      return const Color(0xFF6C757D); // 회색 - 운행 종료
    } else if (nextBusMinDiff <= 3) {
      return const Color(0xFFE74C3C); // 빨강 - 급함
    } else if (nextBusMinDiff <= 8) {
      return const Color(0xFFF39C12); // 주황 - 보통
    } else if (nextBusMinDiff <= 15) {
      return const Color(0xFF3498DB); // 파랑 - 여유
    } else {
      return const Color(0xFF27AE60); // 초록 - 충분한 여유
    }
  }
}
