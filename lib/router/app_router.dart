import 'package:go_router/go_router.dart';
import 'package:habito/views/login.dart';
import 'package:habito/views/intro.dart';
import 'package:habito/views/habit_overview.dart';
import 'package:habito/views/ori_chat.dart';
import 'package:habito/views/register.dart';
import '../views/create_habit.dart';
import '../views/home.dart';
import 'navigation_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const EasyTestLogin(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const Register(),
    ),
    GoRoute(
      path: '/intro',
      name: 'intro',
      builder: (context, state) => const Intro(),
    ),

    ShellRoute(
      builder: (context, state, child) => NavigationShell(child: child),
      routes: [
        GoRoute(
          path: '/create',
          name: 'create',
          builder: (context, state) => const CreateHabitPage(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreenWithHabits(),
        ),
        GoRoute(
          path: '/ori',
          name: 'ori',
          builder: (context, state) => const OriChat(),
        ),
        GoRoute(
          path: '/statistic',
          name: 'statistic',
          builder: (context, state) => const MonthlyHabitOverview(),
        ),
      ],
    ),
  ],
);
