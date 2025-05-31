
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrieren"),
      ),
      body: const Center(
        child: Text("Hier ist dann das Registrierungsformular."),
      ),
    );
  }
}
