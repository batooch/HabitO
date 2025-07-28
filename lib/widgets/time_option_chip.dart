import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_bloc.dart';
import 'package:habito/bloc/habit_time_range/time_range_event.dart';
import 'package:habito/bloc/habit_time_range/time_range_state.dart';

class TimeOptionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback toggle;

  const TimeOptionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.toggle,
  });

  String _getLabelText(String key) {
    switch (key) {
      case 'morning':
        return 'Morgens';
      case 'noon':
        return 'Mittags';
      case 'evening':
        return 'Abends';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeRangeBloc, TimeRangeState>(
      builder: (context, state) {
        final range = state.ranges[label]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChoiceChip(
              label: Text(_getLabelText(label)),
              selected: selected,
              onSelected: (_) => toggle(),
            ),
            if (selected)
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: range.start,
                      );
                      if (picked != null) {
                        context.read<TimeRangeBloc>().add(
                          UpdateTimeRange(
                            period: label,
                            start: picked,
                            end: range.end,
                          ),
                        );
                      }
                    },
                    child: Text('Start: ${range.start.format(context)}'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: range.end,
                      );
                      if (picked != null) {
                        context.read<TimeRangeBloc>().add(
                          UpdateTimeRange(
                            period: label,
                            start: range.start,
                            end: picked,
                          ),
                        );
                      }
                    },
                    child: Text('Ende: ${range.end.format(context)}'),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
