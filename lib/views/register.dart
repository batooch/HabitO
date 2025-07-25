import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

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
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          passwordController.clear();
          context.goNamed('login');
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
              const Text("Nachname:"),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(hintText: "Dein Nachname"),
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
                decoration: const InputDecoration(
                  hintText: "Wähle ein Passwort",
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final firstName = firstNameController.text.trim();
                    final lastName = lastNameController.text.trim();

                    context.read<AuthBloc>().add(
                      RegisterRequested(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                      ),
                    );
                  },
                  child: const Text("Registrieren"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
