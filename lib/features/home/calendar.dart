import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pentru formatarea datei

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  CalendarCardState createState() => CalendarCardState();
}

class CalendarCardState extends State<CalendarCard> {
  DateTime _currentDate = DateTime.now();

  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final int daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    final String monthYear = DateFormat('MMMM yyyy').format(_currentDate);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFF4DFCD), Color(0xFFD2B48C)],
          ),
        ),
        padding: const EdgeInsets.all(16),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _previousMonth,
                ),
                Text(
                  monthYear,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _nextMonth,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(daysInMonth, (int index) {
                    return SizedBox(
                      width: 30,
                      child: Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
