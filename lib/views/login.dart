import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../validators/auth_input_validators.dart';

class EasyTestLogin extends StatefulWidget {
  const EasyTestLogin({super.key});

  @override
  State<EasyTestLogin> createState() => _EasyTestLoginState();
}

class _EasyTestLoginState extends State<EasyTestLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> hasSeenIntro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenIntro') ?? false;
  }

  Future<void> setIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('E-Mail:'),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Deine E-Mail-Adresse',
                  ),
                  validator: AuthInputValidators.validateEmail,
                ),
                const SizedBox(height: 16),
                const Text('Passwort:'),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Dein Passwort'),
                  validator: AuthInputValidators.validatePasswordLogin,
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
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordController.text.trim();

                                    context.read<AuthBloc>().add(
                                      LoginRequested(
                                        email: email,
                                        password: password,
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
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : const Text('Login'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.goNamed('register');
                    },
                    child: const Text(
                      "Noch keinen Account? Jetzt registrieren.",
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
