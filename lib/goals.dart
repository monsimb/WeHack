import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});
  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  bool _isExpanded = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Goals',
          style: TextStyle(
            fontSize: 24, // Match font size to other app bars
            fontWeight: FontWeight.bold, // Match font weight
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: const Color(0xff37798c), // Match the background color
        centerTitle: true, // Center-align the title
        iconTheme:
            const IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center-align containers
          children: [
            // Short Term Goals
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.85, // Stretch width to 85% of screen
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20), // Slightly smaller radius
                  color: const Color.fromARGB(255, 55, 121, 140),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15), // Reduced padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 245, 243, 242),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Short Term",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24, // Slightly smaller font size
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Reduced spacer
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 245, 243, 242),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Concert Tickets: \$150",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Birthday Party: \$200",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Date Night: \$75",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Long Term Goals
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.85, // Stretch width to 85% of screen
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFAAC7C0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15), // Reduced padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 245, 243, 242),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Long Term",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24, // Slightly smaller font size
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Reduced spacer
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 245, 243, 242),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Buy a Car: \$20,000",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Save for Vacation: \$5,000",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Down Payment for House: \$50,000",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Bai Jamjuree',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Add New Goal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.85, // Stretch width to 85% of screen
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffcb2b49),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15), // Reduced padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 245, 243, 242),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "+ New Goal",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24, // Slightly smaller font size
                                  fontFamily: 'Bai Jamjuree',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_isExpanded) ...[
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 245, 243, 242),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Title:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xFFAAC7C0),
                                        ),
                                        child: TextField(
                                          controller: _titleController,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter Goal Title...',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            hintStyle: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Amount:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xFFAAC7C0),
                                        ),
                                        child: TextField(
                                          controller: _amountController,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter Goal Amount...',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            hintStyle: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Save button functionality (currently does nothing)
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffcb2b49),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
