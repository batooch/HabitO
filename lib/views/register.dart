import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../validators/auth_input_validators.dart';

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
  final TextEditingController repeatPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  void _clearFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    repeatPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          _clearFields();
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text("Name:"),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(hintText: "Dein Vorname"),
                  validator: AuthInputValidators.validateName,
                ),
                const SizedBox(height: 16),
                const Text("Nachname:"),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(hintText: "Dein Nachname"),
                  validator: AuthInputValidators.validateName,
                ),
                const SizedBox(height: 16),
                const Text("E-Mail:"),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Deine E-Mail-Adresse",
                  ),
                  validator: AuthInputValidators.validateEmail,
                ),
                const SizedBox(height: 16),
                const Text("Passwort:"),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Wähle ein Passwort",
                  ),
                  validator: AuthInputValidators.validatePasswordRegister,
                ),
                const SizedBox(height: 16),
                const Text("Passwort wiederholen:"),
                TextFormField(
                  controller: repeatPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Passwort bestätigen",
                  ),
                  validator:
                      (value) => AuthInputValidators.validatePasswordRepeat(
                        passwordController.text,
                        value ?? '',
                      ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      RegisterRequested(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        firstName:
                                            firstNameController.text.trim(),
                                        lastName:
                                            lastNameController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                        child:
                            isLoading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text("Registrieren"),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.goNamed('login');
                    },
                    child: const Text(
                      "Bereits einen Account? Jetzt einloggen.",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
