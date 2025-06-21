
import 'package:go_router/go_router.dart';
import 'package:habito/pages/easy_test_login.dart';
import 'package:habito/pages/register.dart';

import '../pages/create_habit/view/create_habit_page.dart';
import '../pages/habit_overview/view/home_screen_with_habits.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreenWithHabits(),
    ),
    GoRoute(
      path: '/create',
      name: 'create',
      builder: (context, state) => const CreateHabitPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const EasyTestLogin(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const Register(),
    ),
  ],
);
