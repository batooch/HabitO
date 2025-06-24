import 'package:go_router/go_router.dart';
import 'package:habito/pages/easy_test_login.dart';
import 'package:habito/pages/intro.dart';
import 'package:habito/pages/monthly_habit_overview.dart';
import 'package:habito/pages/ori_chat.dart';
import 'package:habito/pages/register.dart';
import '../view/create_habit_page.dart';
import '../pages/habit_overview/view/home_screen_with_habits.dart';
import '../pages/home.dart';
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
          path: '/home/no/habit',
          name: 'homeNoHabit',
          builder: (context, state) => const Home(),
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
