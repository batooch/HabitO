import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/bloc/auth/auth_bloc.dart';
import 'package:habito/bloc/auth/auth_event.dart';
import 'package:habito/bloc/auth/auth_state.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_text_styles.dart';
import 'package:habito/constants/app_texts.dart';
import 'package:habito/validators/auth_input_validators.dart';

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
            AppTexts.registerErrorTitle,
            state.message,
            backgroundColor: AppColors.red,
            colorText: AppColors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(AppTexts.registerTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  AppTexts.registerFirstNameLabel,
                  style: AppTextStyles.bodyMedium,
                ),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: AppTexts.registerFirstNameHint,
                  ),
                  validator: AuthInputValidators.validateName,
                ),
                const SizedBox(height: 16),

                Text(
                  AppTexts.registerLastNameLabel,
                  style: AppTextStyles.bodyMedium,
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: AppTexts.registerLastNameHint,
                  ),
                  validator: AuthInputValidators.validateName,
                ),
                const SizedBox(height: 16),

                Text(
                  AppTexts.registerEmailLabel,
                  style: AppTextStyles.bodyMedium,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: AppTexts.registerEmailHint,
                  ),
                  validator: AuthInputValidators.validateEmail,
                ),
                const SizedBox(height: 16),

                Text(
                  AppTexts.registerPasswordLabel,
                  style: AppTextStyles.bodyMedium,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: AppTexts.registerPasswordHint,
                  ),
                  validator: AuthInputValidators.validatePasswordRegister,
                ),
                const SizedBox(height: 16),

                Text(
                  AppTexts.registerPasswordRepeatLabel,
                  style: AppTextStyles.bodyMedium,
                ),
                TextFormField(
                  controller: repeatPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: AppTexts.registerPasswordRepeatHint,
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
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(AppTexts.registerButton),
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
                    child: Text(
                      AppTexts.registerLoginLink,
                      style: AppTextStyles.link,
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
