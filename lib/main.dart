import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habito/bloc/habit/habit_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_event.dart';
import 'package:habito/bloc/user/user_bloc.dart';
import 'package:habito/repository/habit_repository.dart';
import 'package:habito/repository/time_range_repository.dart';
import 'package:habito/router/app_router.dart';
import 'package:habito/services/auth_service.dart';



import 'bloc/auth/auth_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(AuthService())),
        BlocProvider<HabitBloc>(
          create: (context) => HabitBloc(HabitRepository()),
        ),
        BlocProvider<UserBloc>(create: (context) => UserBloc(AuthService())),
        BlocProvider<TimeRangeBloc>(
          create: (context) => TimeRangeBloc(TimeRangeRepository())..add(LoadTimeRanges()),
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
      ),
      supportedLocales: const [
        Locale('de'), // Deutsch
      ],
      locale: const Locale('de'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
