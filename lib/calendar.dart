import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 55, 121, 140),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TableCalendar(
            //   firstDay: DateTime.utc(2000, 1, 1),
            //   lastDay: DateTime.utc(2100, 12, 31),
            //   focusedDay: _focusedDay,
            //   selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            //   onDaySelected: (selectedDay, focusedDay) {
            //     setState(() {
            //       _selectedDay = selectedDay;
            //       _focusedDay = focusedDay;
            //     });
            //   },
            //   calendarStyle: const CalendarStyle(
            //     todayDecoration: BoxDecoration(
            //       color: Colors.blue,
            //       shape: BoxShape.circle,
            //     ),
            //     selectedDecoration: BoxDecoration(
            //       color: Colors.green,
            //       shape: BoxShape.circle,
            //     ),
            //   ),
            //   headerStyle: const HeaderStyle(
            //     formatButtonVisible: false,
            //     titleCentered: true,
            //   ),
            // ),
            const SizedBox(height: 20),
            if (_selectedDay != null)
              Text(
                'Selected Day: ${_selectedDay!.toLocal()}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
