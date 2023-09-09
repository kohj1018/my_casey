import 'package:flutter/material.dart';
import 'package:my_casey/component/bus_time_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              BusTimeCard(busType: 'H221', lastBusTime: '17:55', nextBusTime: '20:20'),
              SizedBox(height: 16.0),
              BusTimeCard(busType: 'H221', lastBusTime: '17:55', nextBusTime: '20:20'),
              SizedBox(height: 16.0),
              BusTimeCard(busType: 'H221', lastBusTime: '17:55', nextBusTime: '20:20'),
            ],
          ),
        ),
      ),
    );
  }
}
