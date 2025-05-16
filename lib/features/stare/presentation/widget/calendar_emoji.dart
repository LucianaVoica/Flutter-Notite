import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmojiCalendar extends StatefulWidget {
  const EmojiCalendar({super.key});

  @override
  State<EmojiCalendar> createState() => _EmojiCalendarState();
}

class _EmojiCalendarState extends State<EmojiCalendar> {
  final Map<DateTime, String> moodMap = <DateTime, String>{};
  final DateTime _focusedMonth = DateTime.now();

  final List<String> emojiOptions = <String>['😊', '😐', '🤒', '😡'];

  Future<void> _selectMood(DateTime date) async {
    final String? selectedEmoji = await showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 300, 100, 100),
      items:
          emojiOptions.map((String emoji) {
            return PopupMenuItem<String>(
              value: emoji,
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            );
          }).toList(),
    );

    if (selectedEmoji != null) {
      setState(() {
        moodMap[DateTime(date.year, date.month, date.day)] = selectedEmoji;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = DateUtils.getDaysInMonth(
      _focusedMonth.year,
      _focusedMonth.month,
    );
    final int firstWeekday =
        DateTime(_focusedMonth.year, _focusedMonth.month).weekday;

    final List<Widget> dayWidgets = <Widget>[];

    // Add empty boxes for alignment
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime date = DateTime(
        _focusedMonth.year,
        _focusedMonth.month,
        day,
      );
      final String? emoji = moodMap[DateTime(date.year, date.month, date.day)];

      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectMood(date),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: emoji == null ? Colors.grey.shade200 : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(emoji ?? '$day', style: const TextStyle(fontSize: 20)),
          ),
        ),
      );
    }

    return Column(
      children: [
        Text(
          DateFormat.yMMMM().format(_focusedMonth),
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: dayWidgets,
        ),
      ],
    );
  }
}
