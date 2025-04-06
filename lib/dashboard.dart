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
  Map<String, double> categoryData = {};

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

  String generateTip() {
    if (categoryData.isEmpty) {
      return "Track your spending to see insights here!";
    }

    // Find the category with the highest percentage
    final highestCategory =
        categoryData.entries.reduce((a, b) => a.value > b.value ? a : b);

    return "Tip: Consider reducing your spending on ${highestCategory.key} (${highestCategory.value.toStringAsFixed(1)}%).";
  }

  List<Map<String, String>> generateQuests() {
    return [
      {
        "title": "Spend max \$15 for the next 3 days",
        "description":
            "Track your daily expenses and ensure you spend less than \$15 for the next 3 days."
      },
      {
        "title": "Save time for yourself",
        "description":
            "Block a time on your calendar to remind yourself to take a short break every 90 minutes."
      },
      {
        "title": "Auto-transfer \$10 to savings today",
        "description":
            "Boost your savings by transferring \$10 to your savings account today."
      },
    ];
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
              const SizedBox(height: 30.0),

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

              const SizedBox(height: 30),

              // Pie Chart Section with Tip
              Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tip Label
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        generateTip(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    // Pie Chart Container
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xfff5f3f2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: categoryData.isEmpty
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
                                        sections:
                                            categoryData.entries.map((entry) {
                                          return PieChartSectionData(
                                            value: entry.value,
                                            color: _getCategoryColor(entry.key),
                                            title:
                                                '${entry.value.toStringAsFixed(1)}%',
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
                            Column(
                              children: categoryData.entries.map((entry) {
                                return LegendItem(
                                  color: _getCategoryColor(entry.key),
                                  text: entry.key,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Recent Purchases Section
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xff37798c),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
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

              const SizedBox(height: 30),

              // Smart Assistant Quests Section
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xfff5f3f2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Smart Assistant Quests",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ...generateQuests().map((quest) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xff37798c),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quest["title"]!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      quest["description"]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
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
