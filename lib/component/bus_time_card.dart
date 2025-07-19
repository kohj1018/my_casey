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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              _buildBusTypeSection(),
              const SizedBox(width: 16.0),
              Expanded(child: _buildTimeSection()),
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
          Text(
            'operationEnded'.tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 다음 버스 정보 (메인)
        _buildNextBusInfo(),
        
        // 구분선
        if (lastBusMinDiff >= 0) ...[
          const SizedBox(height: 8),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
          _buildPreviousBusInfo(),
        ],
      ],
    );
  }

  Widget _buildNextBusInfo() {
    String modifiedNextBusTime = nextBusTime.startsWith('24') ? nextBusTime.replaceFirst('24', '00') : nextBusTime;
    
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'nextBus'.tr(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$nextBusMinDiff',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'minutesUntilArrival'.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            _buildProgressBar(),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 16,
              ),
              const SizedBox(height: 2),
              Text(
                modifiedNextBusTime,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'scheduledDeparture'.tr(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviousBusInfo() {
    String modifiedLastBusTime = lastBusTime.startsWith('24') ? lastBusTime.replaceFirst('24', '00') : lastBusTime;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'recentBus'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.history,
              color: Colors.white.withOpacity(0.9),
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              modifiedLastBusTime,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '($lastBusMinDiff${'minutesAgo'.tr()})',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
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
      return const Color(0xFF64748B); // 세련된 슬레이트 그레이
    } else if (nextBusMinDiff <= 3) {
      return const Color(0xFFEF4444); // 모던 레드 (긴급)
    } else if (nextBusMinDiff <= 8) {
      return const Color(0xFFF59E0B); // 세련된 앰버 (주의)
    } else if (nextBusMinDiff <= 15) {
      return const Color(0xFF3B82F6); // 모던 블루 (안정)
    } else {
      return const Color(0xFF10B981); // 세련된 에메랄드 (여유)
    }
  }
}
