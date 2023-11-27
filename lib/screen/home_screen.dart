import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_casey/screen/bus_schedule_screen.dart';
import 'package:my_casey/screen/calendar_screen.dart';
import 'package:my_casey/screen/opening_hours_screen.dart';

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

    final List<Widget> _widgetOptions = [
      const BusScheduleScreen(),
      const CalendarScreen(),
      const OpeningHoursScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _widgetOptions.elementAt(_selectedTapIdx)
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.bus_alert_rounded),
            label: 'timeTable'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: '${'schedule'.tr()}(v3)',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.punch_clock),
            label: 'openingHours'.tr(),
          ),
        ],
        currentIndex: _selectedTapIdx,
        onTap: _onItemTapped,
      ),
    );
  }
}
