import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class EasyTestLogin extends StatefulWidget {
  const EasyTestLogin({super.key});

  @override
  State<EasyTestLogin> createState() => _EasyTestLoginState();
}

class _EasyTestLoginState extends State<EasyTestLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> hasSeenIntro() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenIntro') ?? false;
  }

  Future<void> setIntroSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is Authenticated) {
          final seenIntro = await hasSeenIntro();

          if (!seenIntro) {
            await setIntroSeen();
            context.goNamed('intro');
          } else {
            context.goNamed('home');
          }
        } else if (state is AuthError) {
          Get.snackbar(
            "Fehler",
            state.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('E-Mail:'),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Deine E-Mail-Adresse',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Passwort:'),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Dein Passwort'),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    context.read<AuthBloc>().add(
                      LoginRequested(email: email, password: password),
                    );
                  },
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.goNamed('register');
                  },
                  child: const Text("Noch keinen Account? Jetzt registrieren"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
