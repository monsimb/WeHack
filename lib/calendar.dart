import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'goals.dart';

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
      body: SingleChildScrollView( 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GoalsPage()),
                );
              },
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xffcb2b49)),
                child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromARGB(255, 245, 243, 242)),
                        child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Monthly Goals",
                              style: TextStyle(color: Colors.black,
                                fontSize: 28,
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          )
                        )
                      ),
                      SizedBox(height: 16),   // spacer
                      Row(
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 245, 243, 242)
                            ),
                            child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Short Term",
                                    style: TextStyle(color: Color.fromARGB(255, 55, 121, 140),
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 1: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 2: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 3: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                              ]
                            )
                            )
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(255, 245, 243, 242)
                            ),
                            child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Long Term",
                                    style: TextStyle(color: Color.fromARGB(255, 55, 121, 140),
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 1: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 2: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 3: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                              ]
                            )
                            )
                          ),
                        ],)
                      ]
                    ),
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedDay != null)
              Text(
                'Selected Day: ${_selectedDay!.toLocal()}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      )),
    );
  }
}
