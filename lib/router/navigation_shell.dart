import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_texts.dart';

class NavigationShell extends StatelessWidget {
  final Widget child;

  const NavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.primaryGreen,
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(color: AppColors.backgroundSoft),
          ),
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: AppColors.backgroundSoft),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _calculateSelectedIndex(context),
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.goNamed('home');
                break;
              case 1:
                context.goNamed('statistic');
                break;
              case 2:
                context.goNamed('create');
                break;
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: AppTexts.navHome,
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart),
              label: AppTexts.navOverview,
            ),
            NavigationDestination(
              icon: Icon(Icons.add),
              label: AppTexts.navCreate,
            ),
          ],
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/statistic')) return 1;
    if (location.startsWith('/create')) return 2;
    return 0;
  }
}
