import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add this package for the pie chart
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<Map<String, dynamic>>> _recentPurchases;
  Map<String, double> categoryData = {
    "Shopping": 46.1,
    "Bills": 28.7,
    "Transport": 16.2,
    "Other": 9.0,
  };

  @override
  void initState() {
    super.initState();
    _recentPurchases = fetchRecentPurchases("default");
  }

  Future<List<Map<String, dynamic>>> fetchRecentPurchases(String userId) async {
    final Uri uri = Uri.parse(
        'https://rag-ai.moniquesimberg.workers.dev/recent-purchases?userId=$userId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final purchases =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      calculateCategoryData(purchases);
      return purchases;
    } else {
      throw Exception('Failed to load recent purchases');
    }
  }

  void calculateCategoryData(List<Map<String, dynamic>> purchases) {
    // Set fixed percentages for the pie chart
    categoryData = {
      "Shopping": 46.1,
      "Bills": 28.7,
      "Transport": 16.2,
      "Other": 9.0,
    };

    setState(() {});
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0), // Bring down all containers

              // Welcome Back Card
              Container(
                width: 400,
                height: 90,
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

              // Pie Chart and Legend Background Overlay
              Container(
                width: 400, // Match the width of Recent Purchases
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xfff5f3f2), // Solid #f5f3f2 background
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Pie Chart
                      SizedBox(
                        height: 200,
                        child: categoryData.values.every((value) => value == 0)
                            ? const Center(
                                child: Text(
                                  "No data available for the pie chart.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : PieChart(
                                PieChartData(
                                  sections: categoryData.entries.map((entry) {
                                    final total = categoryData.values
                                        .reduce((a, b) => a + b);
                                    final percentage =
                                        (entry.value / total) * 100;
                                    return PieChartSectionData(
                                      value: entry.value,
                                      color: _getCategoryColor(entry.key),
                                      title:
                                          '${percentage.toStringAsFixed(1)}%', // Display percentage
                                      titleStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    );
                                  }).toList(),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                ),
                              ),
                      ),

                      const SizedBox(height: 16.0),

                      // Legend (Two Lines)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              LegendItem(
                                  color: Color(0xffcb2b49),
                                  text: 'Shopping'), // Changed from Food
                              LegendItem(
                                  color: Color(0xffaac7c0), text: 'Transport'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              LegendItem(
                                  color: Color(0xff37798c),
                                  text: 'Bills'), // Changed from Shopping
                              LegendItem(color: Colors.grey, text: 'Other'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Recent Purchases Card
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xff37798c), // Dark blue overlay
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Recent Purchases Title
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
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // Display Recent Purchases
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: _recentPurchases,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No recent purchases found.');
                            } else {
                              final purchases = snapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: purchases.length,
                                itemBuilder: (context, index) {
                                  final purchase = purchases[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Container(
                                      width: 330,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color(0xfff5f3f2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Align date and amount on the left
                                            Row(
                                              children: [
                                                Text(
                                                  purchase['date'],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  '\$${purchase['amount'].toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Merchant name on the right
                                            Text(
                                              purchase['description'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Shopping":
        return const Color(0xffcb2b49);
      case "Bills":
        return const Color(0xffaac7c0);
      case "Transport":
        return const Color(0xff37798c);
      default:
        return Colors.grey; // "Other"
    }
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
