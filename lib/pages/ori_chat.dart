import 'package:flutter/material.dart';

class OriChat extends StatelessWidget {
  const OriChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi moin Meister ich bin Ori"),
      ),
      body: const Center(
        child: Text("Frag mich mal was"),
      ),
    );
  }
}
