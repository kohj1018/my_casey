import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_casey/screen/bus_schedule_screen.dart';
import 'package:my_casey/screen/calendar_screen.dart';
import 'package:my_casey/screen/opening_hours_screen.dart';
import 'package:my_casey/theme/app_theme.dart';
import 'package:my_casey/component/simple_banner_ad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTapIdx = 0;

  void _onItemTapped(int idx) {
    setState(() {
      _selectedTapIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
      const BusScheduleScreen(),
      const CalendarScreen(),
      const OpeningHoursScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.surface,
              AppColors.background,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        // 🚀 핵심 해결책: SingleChildScrollView로 오버플로우 해결 + 페이지 전환 정상 작동
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 
                          MediaQuery.of(context).padding.top - 
                          MediaQuery.of(context).padding.bottom - 
                          140, // 광고 + 네비게이션 바 높이 고려
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                child: widgetOptions.elementAt(_selectedTapIdx),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 광고 배너
            const SimpleBannerAd(),
            
            // 네비게이션 바
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimary.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedTapIdx,
                  onTap: _onItemTapped,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.textTertiary,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  iconSize: 24,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        _selectedTapIdx == 0
                            ? Icons.directions_bus_rounded
                            : Icons.directions_bus_outlined,
                      ),
                      label: 'timeTable'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        _selectedTapIdx == 1
                            ? Icons.calendar_month_rounded
                            : Icons.calendar_month_outlined,
                      ),
                      label: '${'schedule'.tr()}(v1)',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        _selectedTapIdx == 2
                            ? Icons.access_time_filled_rounded
                            : Icons.access_time_outlined,
                      ),
                      label: 'openingHours'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
