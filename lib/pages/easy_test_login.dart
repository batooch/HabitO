import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito/pages/register.dart';

class EasyTestLogin extends StatelessWidget {
  const EasyTestLogin({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('E-Mail:'),
            TextField(

              decoration: const InputDecoration(
                hintText: 'Deine E-Mail-Adresse',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Passwort:'),
            TextField(

              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Dein Passwort',
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {

                },
                child: const Text('Login'),
              ),
            ),
                const SizedBox(height:32),
                Center (
                child: TextButton(
                onPressed: () => Get.to(() => const Register()),
                child: const Text ("Noch keinen Account? Jetzt registrieren"),
                ),
            )

          ],
        ),
      ),
    );
  }
}
