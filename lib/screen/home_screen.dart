import 'package:flutter/material.dart';
import 'package:my_casey/screen/bus_schedule_screen.dart';
import 'package:my_casey/screen/calendar_screen.dart';

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
      BusScheduleScreen(),
      CalendarScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _widgetOptions.elementAt(_selectedTapIdx)
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert_rounded),
            label: '버스시간표',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '일정',
          ),
        ],
        currentIndex: _selectedTapIdx,
        onTap: _onItemTapped,
      ),
    );
  }
}
