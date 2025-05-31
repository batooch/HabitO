import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habito/pages/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose () {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              controller: firstNameController,
              decoration: const InputDecoration(hintText: "Dein Vorname"),
            ),

            const SizedBox(height: 16),

            const Text("Nachnahme:"),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(hintText: "Dein Nachnahme"),
            ),

            const SizedBox(height: 16),

            const Text("E-Mail:"),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Deine E-Mail-Adresse",
              ),
            ),

            const SizedBox(height: 16),
            const Text("Passwort"),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Wähle ein Passwort"),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Get.to(() => const Splash()),
                child: const Text("Registrieren"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
