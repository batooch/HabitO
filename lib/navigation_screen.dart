import 'package:flutter/material.dart';
import 'package:habito/pages/create_habit_page.dart';
import 'package:habito/pages/home.dart';
import 'package:habito/pages/monthly_habit_overview.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    MonthlyHabitOverview(),
    CreateHabitPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectIndex,
        onDestinationSelected: (index){
          setState(() {
            _selectIndex = index;
          });
        },
        destinations: const[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Statistik'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Habit erstellen'),
        ],
      ),
    );
  }
}
