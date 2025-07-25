import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6ED),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/images/LogoHabitO.jpeg', height: 120),
                const SizedBox(height: 40),
                const Text(
                  "Willkommen bei\nHabit-O.",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF173B2F),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Hier kannst du\ndeine Ziele erreichen\nin dem du Gewohnheiten anlegst.\n\n"
                  "Du hast ein Ziel, aber weißt nicht,\nwo du anfangen sollst?\n\n"
                  "Kein Problem. Ori, dein\npersönlicher KI-Assistent\nunterstützt dich gerne dabei.",
                  style: TextStyle(fontSize: 16, color: Color(0xFF173B2F)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed('home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF173B2F),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black26,
                  ),
                  child: const Text(
                    "Los geht’s!",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
