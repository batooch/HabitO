import 'package:flutter/material.dart';
import '../widgets/logout_button.dart';

class UserMenu extends StatelessWidget {
  final String firstName;

  const UserMenu({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.person, color: Colors.black),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder:
          (context) => [
            PopupMenuItem(
              enabled: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, $firstName!',
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
  }
}
