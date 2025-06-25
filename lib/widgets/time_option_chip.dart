import 'package:flutter/material.dart';
import '../models/time_of_day_range.dart';

class TimeOptionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback toggle;
  final TimeOfDayRange range;

  const TimeOptionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.toggle,
    required this.range,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChoiceChip(
          label: Text(_getLabelText(label)),
          selected: selected,
          onSelected: (_) => toggle(),
        ),
        if (selected)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(range.toString(), style: const TextStyle(fontSize: 16)),
          ),
      ],
    );
  }
}
