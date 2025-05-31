import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habito/pages/splash.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrieren")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text("Name:"),
            TextField(
              decoration: const InputDecoration(hintText: "Dein Vorname"),
            ),

            const SizedBox(height: 16),

            const Text("Nachnahme:"),
            TextField(
              decoration: const InputDecoration(hintText: "Dein Nachnahme"),
            ),

            const SizedBox(height: 16),

            const Text("E-Mail:"),
            TextField(
              decoration: const InputDecoration(
                hintText: "Deine E-Mail-Adresse",
              ),
            ),

            const SizedBox(height: 16),
            const Text("Passwort"),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Wähle ein Passwort"
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Get.to(() => const Splash()),
                  child: const Text("Registrieren"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
