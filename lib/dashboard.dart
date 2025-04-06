import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add this package for the pie chart

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff37798c), // Match the dashboard theme
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Shift containers to the right
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0), // Bring down all containers

              // Welcome Back Card
              Container(
                width: 359,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffcb2b49),
                ),
                child: const Center(
                  child: Text(
                    "Welcome Back, Khoa!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30), // Existing spacing

              // Recent Purchases Card
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xff37798c),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xfff5f3f2),
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Recent Purchases",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontFamily: 'Bai Jamjuree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )))),
                          const SizedBox(height: 20),

                          // Combined Pie Chart and Legend Overlay
                          Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xfff5f3f2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis
                                    .horizontal, // Enable horizontal scrolling
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Align content to the start
                                  children: [
                                    const SizedBox(
                                        width:
                                            35), // Add spacing to shift content to the right

                                    // Pie Chart
                                    Container(
                                      width: 70,
                                      height: 200,
                                      child: PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              value: 35,
                                              color: Colors.blue,
                                              title: '35%',
                                              titleStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            PieChartSectionData(
                                              value: 25,
                                              color: Colors.green,
                                              title: '25%',
                                              titleStyle: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            PieChartSectionData(
                                              value: 20,
                                              color: Colors.orange,
                                              title: '20%',
                                              titleStyle: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            PieChartSectionData(
                                              value: 10,
                                              color: Colors.red,
                                              title: '10%',
                                              titleStyle: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            PieChartSectionData(
                                              value: 10,
                                              color: Colors.purple,
                                              title: '10%',
                                              titleStyle: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                          sectionsSpace: 2,
                                          centerSpaceRadius: 40,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),

                                    // Legend
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              48.0), // Shift legend 3 units to the right
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          LegendItem(
                                              color: Colors.blue,
                                              text: 'Groceries'),
                                          SizedBox(height: 6),
                                          LegendItem(
                                              color: Colors.green,
                                              text: 'Bills'),
                                          SizedBox(height: 6),
                                          LegendItem(
                                              color: Colors.orange,
                                              text: 'Hobbies'),
                                          SizedBox(height: 6),
                                          LegendItem(
                                              color: Colors.red,
                                              text: 'Savings'),
                                          SizedBox(height: 6),
                                          LegendItem(
                                              color: Colors.purple,
                                              text: 'Misc.'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(height: 25),

              // This Week's Spending Card
              Container(
                width: 359,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffaac7c0),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "This Week’s Spending",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (var dayData in [
                      {"day": "SUN", "amount": "\$40", "category": "Food"},
                      {"day": "MON", "amount": "\$15", "category": "Transport"},
                      {"day": "TUE", "amount": "\$25", "category": "Shopping"},
                      {"day": "WED", "amount": "\$10", "category": "Other"},
                      {"day": "THU", "amount": "\$30", "category": "Food"},
                      {"day": "FRI", "amount": "\$20", "category": "Transport"},
                      {"day": "SAT", "amount": "\$50", "category": "Shopping"},
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          width: 330,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xfff5f3f2),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dayData["day"]!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      dayData["amount"]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      dayData["category"]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
