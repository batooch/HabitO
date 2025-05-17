import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hallo ich bin eine Startseite."),
      ),
      body: const Center(
        child: Text("Das ist der body der Startseite."),
      ),
    );
  }
}
