import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add this package for the pie chart

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container 1: Header
            Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color(0xFF35798C), // Header background color
              child: const Text(
                'Welcome Back, User.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Container 2: Recent Purchases with Pie Chart
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Purchases',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 40,
                            color: Colors.blue,
                            title: 'Food',
                          ),
                          PieChartSectionData(
                            value: 30,
                            color: Colors.green,
                            title: 'Transport',
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.orange,
                            title: 'Shopping',
                          ),
                          PieChartSectionData(
                            value: 10,
                            color: Colors.red,
                            title: 'Other',
                          ),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Container 3: This Week's Spending
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "This Week's Spending",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: List.generate(7, (index) {
                      final days = [
                        'Sunday',
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday'
                      ];
                      final colors = [
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.red,
                        Colors.purple,
                        Colors.yellow,
                        Colors.teal
                      ];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        color: const Color(0xFFF5F3F2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              days[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: colors[index],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
