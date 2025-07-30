import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:habito/bloc/auth/auth_bloc.dart';
import 'package:habito/bloc/auth/auth_event.dart';
import 'package:habito/bloc/auth/auth_state.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_texts.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              current is Unauthenticated || current is AuthError,
      listener: (context, state) {
        if (state is Unauthenticated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text(AppTexts.logoutSuccess)));
          context.goNamed('login');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: TextButton.icon(
        onPressed: () {
          context.read<AuthBloc>().add(const LogoutRequested());
        },
        icon: const Icon(Icons.logout, color: AppColors.red),
        label: const Text('Logout', style: TextStyle(color: AppColors.red)),
      ),
    );
  }
}
