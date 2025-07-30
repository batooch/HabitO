import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:habito/bloc/habit/habit_bloc.dart';
import 'package:habito/bloc/habit/habit_event.dart';
import 'package:habito/bloc/habit/habit_state.dart';
import 'package:habito/bloc/user/user_bloc.dart';
import 'package:habito/bloc/user/user_event.dart';
import 'package:habito/bloc/habit_time_range/time_range_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_state.dart';
import 'package:habito/constants/app_text_styles.dart';
import 'package:habito/constants/app_texts.dart';

import 'package:habito/models/habit.dart';
import 'package:habito/widgets/custom_fab.dart';
import 'package:habito/widgets/habit_details_dialog.dart';
import 'package:habito/widgets/habit_time_section.dart';
import 'package:habito/widgets/user_menu.dart';

class HomeScreenWithHabits extends StatefulWidget {
  const HomeScreenWithHabits({super.key});

  @override
  State<HomeScreenWithHabits> createState() => _HomeScreenWithHabitsState();
}

class _HomeScreenWithHabitsState extends State<HomeScreenWithHabits> {
  @override
  void initState() {
    super.initState();
    context.read<HabitBloc>().add(LoadHabits());

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      context.read<UserBloc>().add(LoadUserData(uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabitBloc, HabitState>(
      listenWhen: (previous, current) => current is HabitError,
      listener: (context, state) {
        if (state is HabitError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: const [
            Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppTexts.homeHeadline, style: AppTextStyles.headlineLarge),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<HabitBloc, HabitState>(
                    builder: (context, habitState) {
                      if (habitState is HabitLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (habitState is HabitError) {
                        return Center(
                          child: Text('Fehler: ${habitState.message}'),
                        );
                      } else if (habitState is HabitLoaded) {
                        final habits = habitState.habits;

                        if (habits.isEmpty) {
                          return const Center(
                            child: Text(
                              AppTexts.homeScreenNoHabits,
                              style: AppTextStyles.bodyMedium,
                            ),
                          );
                        }

                        final morningHabits =
                            habits.where((h) => h.morning != null).toList();
                        final noonHabits =
                            habits.where((h) => h.noon != null).toList();
                        final eveningHabits =
                            habits.where((h) => h.evening != null).toList();

                        return BlocBuilder<TimeRangeBloc, TimeRangeState>(
                          builder: (context, timeState) {
                            final morningTime =
                                timeState.ranges['morning']?.toString() ?? '';
                            final noonTime =
                                timeState.ranges['noon']?.toString() ?? '';
                            final eveningTime =
                                timeState.ranges['evening']?.toString() ?? '';

                            return ListView(
                              children: [
                                if (morningHabits.isNotEmpty)
                                  HabitTimeSection(
                                    title: AppTexts.morning,
                                    timeText: morningTime,
                                    habits: morningHabits,
                                    onHabitTap: _showHabitDetailsDialog,
                                    onCheckboxChanged: (habit, value) {
                                      context.read<HabitBloc>().add(ToggleHabitDone(habit.id!, value));
                                    },
                                  ),
                                if (noonHabits.isNotEmpty)
                                  HabitTimeSection(
                                    title: AppTexts.midday,
                                    timeText: noonTime,
                                    habits: noonHabits,
                                    onHabitTap: _showHabitDetailsDialog,
                                    onCheckboxChanged: (habit, value) {
                                      context.read<HabitBloc>().add(ToggleHabitDone(habit.id!, value));
                                    },
                                  ),
                                if (eveningHabits.isNotEmpty)
                                  HabitTimeSection(
                                    title: AppTexts.evening,
                                    timeText: eveningTime,
                                    habits: eveningHabits,
                                    onHabitTap: _showHabitDetailsDialog,
                                    onCheckboxChanged: (habit, value) {
                                      context.read<HabitBloc>().add(ToggleHabitDone(habit.id!, value));
                                    },
                                  ),
                              ],
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const CustomFAB(),
      ),
    );
  }

  void _showHabitDetailsDialog(Habit habit) {
    showDialog(
      context: context,
      builder:
          (context) => HabitDetailsDialog(
            habit: habit,
            onDelete: () async {
              context.read<HabitBloc>().add(DeleteHabit(habit.id!));
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppTexts.habitDeleted),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
    );
  }
}
