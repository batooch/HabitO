import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/bloc/user/user_bloc.dart';
import 'package:habito/bloc/user/user_state.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_text_styles.dart';
import 'package:habito/constants/app_texts.dart';
import 'package:habito/widgets/logout_button.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return PopupMenuButton<int>(
            icon: const Icon(Icons.person, color: AppColors.black),
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppTexts.userMenuGreeting} ${state.firstName}!',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () {
                            context.goNamed('myprofile');
                          },
                          child: Text(
                            AppTexts.userMenuProfile,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                        const Divider(),
                        const LogoutButton(),
                      ],
                    ),
                  ),
                ],
          );
        } else if (state is UserLoading) {
          return const CircularProgressIndicator();
        } else {
          return const Icon(Icons.person_outline);
        }
      },
    );
  }
}
