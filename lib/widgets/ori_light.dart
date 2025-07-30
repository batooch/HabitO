import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habito/constants/app_text_styles.dart';
import 'package:habito/constants/app_texts.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/services/ori_service.dart';
import 'package:habito/bloc/habit/habit_bloc.dart';
import 'package:habito/bloc/habit/habit_state.dart';

class HabitSuggestions extends StatelessWidget {
  HabitSuggestions({super.key});

  final OriService _oriService = OriService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      builder: (context, state) {
        if (state is HabitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HabitLoaded) {
          final titles = state.habits.map((h) => h.title).toList();

          return FutureBuilder<List<String>>(
            future: _oriService.fetchSuggestions(titles),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Fehler: ${snapshot.error}',
                  style: AppTextStyles.bodyMedium,
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text(
                  AppTexts.oriNoSuggestionsFound,
                  style: AppTextStyles.bodyMedium,
                );
              }

              final suggestions = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    color: AppColors.suggestionCard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        suggestions[index],
                        style: AppTextStyles.suggestionText,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is HabitError) {
          return Text(
            'Fehler: ${state.message}',
            style: AppTextStyles.bodyMedium,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
