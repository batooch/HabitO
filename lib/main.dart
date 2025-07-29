import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habito/bloc/habit/habit_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_event.dart';
import 'package:habito/bloc/user/user_bloc.dart';
import 'package:habito/interfaces/i_auth_service.dart';
import 'package:habito/interfaces/i_habit_repository.dart';
import 'package:habito/interfaces/i_time_range_repository.dart';
import 'package:habito/repository/habit_repository.dart';
import 'package:habito/repository/time_range_repository.dart';
import 'package:habito/router/app_router.dart';
import 'package:habito/services/auth_service.dart';
import 'package:habito/bloc/auth/auth_bloc.dart';
import 'package:habito/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final IAuthService authService = AuthService();
  final IHabitRepository habitRepository = HabitRepository();
  final ITimeRangeRepository timeRangeRepository = TimeRangeRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authService)),
        BlocProvider<HabitBloc>(
          create: (context) => HabitBloc(habitRepository),
        ),
        BlocProvider<UserBloc>(create: (context) => UserBloc(authService)),
        BlocProvider<TimeRangeBloc>(
          create:
              (context) =>
                  TimeRangeBloc(timeRangeRepository)..add(LoadTimeRanges()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'habitO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      supportedLocales: const [Locale('de')],
      locale: const Locale('de'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
