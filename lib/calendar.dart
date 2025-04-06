import 'package:flutter/material.dart';
import 'package:plan_it/goals.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _eventDay;
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  List<Map<String, dynamic>> _goals = []; // Store fetched goals

  @override
  void initState() {
    super.initState();
    _fetchCalendarEvents();
    _fetchGoals(); // Fetch goals on initialization
  }

  Future<void> _fetchCalendarEvents() async {
    final Uri uri =
        Uri.parse('https://rag-ai.moniquesimberg.workers.dev/calendar-events');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final Map<DateTime, List<Map<String, dynamic>>> events = {};

      for (var event in data) {
        DateTime eventDate = DateTime.parse(event['start']['dateTime']);
        eventDate = DateTime(eventDate.year, eventDate.month, eventDate.day);

        final DateTime startTime =
            DateTime.parse(event['start']['dateTime']).toLocal();
        final DateTime endTime =
            DateTime.parse(event['end']['dateTime']).toLocal();
        final String formattedStartTime =
            DateFormat('hh:mm a').format(startTime);
        final String formattedEndTime = DateFormat('hh:mm a').format(endTime);

        if (!events.containsKey(eventDate)) {
          events[eventDate] = [];
        }
        events[eventDate]!.add({
          'summary': event['summary'],
          'start': formattedStartTime, // Use the formatted start time
          'end': formattedEndTime, // Use the formatted end time
        });
      }

      setState(() {
        _events = events;
      });
    } else {
      throw Exception('Failed to load calendar events');
    }
  }

  Future<void> _fetchGoals() async {
    final Uri uri =
        Uri.parse('https://rag-ai.moniquesimberg.workers.dev/goals');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        // Extract only short-term goals
        _goals = List<Map<String, dynamic>>.from(data["shortTerm"]);
      });
    } else {
      throw Exception('Failed to load goals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff37798c), // Match the dashboard theme
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
              height: 20), // Add padding between AppBar and Monthly Goals

          // Move Monthly Goals to the top
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GoalsPage()),
              );
            },
            child: Container(
              width: 345, // Keep the width as is
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust border radius
                color: const Color(0xffcb2b49),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                    15), // Reduced padding to make it smaller
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromARGB(255, 245, 243, 242),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(
                            8), // Reduced padding inside the title
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Monthly Goals",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16, // Keep font size as is
                              fontFamily: 'Bai Jamjuree',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 5), // Reduced spacing between title and goals
                    if (_goals.isNotEmpty)
                      Column(
                        children: _goals.map((goal) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0), // Reduced vertical padding
                            child: Container(
                              width: 315, // Keep the width as is
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color.fromARGB(255, 245, 243, 242),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8), // Reduced padding inside each goal
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      goal['title'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12, // Keep font size as is
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Progress: ${goal['progress']}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10, // Keep font size as is
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    else
                      const Text(
                        'No goals available.',
                        style: TextStyle(fontSize: 10), // Keep font size as is
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Calendar Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height:
                          350, // Adjusted height to make the calendar slightly smaller
                      child: TableCalendar(
                        firstDay: DateTime.utc(2000, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _eventDay = DateTime(
                              _selectedDay!.year,
                              _selectedDay!.month,
                              _selectedDay!.day,
                            );
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarStyle: const CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Color.fromARGB(127, 125, 183, 230),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color.fromARGB(127, 170, 199, 192),
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Display events for the selected day
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(
                          10.0), // Reduced padding to make it smaller
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(127, 170, 199, 192),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                              20), // Rounded both top and bottom corners
                        ),
                      ),
                      child: _selectedDay != null && _events[_eventDay] != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Events for ${DateFormat('MMMM d, yyyy').format(_selectedDay!)}:',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ..._events[_eventDay]!.map((event) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      event['summary'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Start: ${event['start']}\nEnd: ${event['end']}',
                                    ),
                                  );
                                }).toList(),
                              ],
                            )
                          : Center(
                              child: Text(
                                _selectedDay != null
                                    ? 'No events for ${DateFormat('MMMM d, yyyy').format(_selectedDay!)}.'
                                    : 'No day selected.',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
