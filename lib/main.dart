import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito/navigation_screen.dart';
import 'package:habito/pages/create_habit_page.dart';
import 'package:habito/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'habitO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      initialRoute: '/nav',
      getPages: [
        GetPage(name: '/nav', page: () => const NavigationScreen()),
        GetPage(name: '/create', page:() => const CreateHabitPage()),
        GetPage(name: '/ori', page: () => const CreateHabitPage())
      ],
    );
  }
}

