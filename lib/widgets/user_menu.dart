import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_state.dart';
import '../widgets/logout_button.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return PopupMenuButton<int>(
            icon: const Icon(Icons.person, color: Colors.black),
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
                          'Hallo, ${state.firstName}!',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Mein Profil'),
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
