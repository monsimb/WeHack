import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});
  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  bool _isExpanded = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Goals',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 55, 121, 140),
        iconTheme:
            const IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 55, 121, 140)),
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
                            "Short Term",
                            style: TextStyle(color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Bai Jamjuree',
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        )
                      )
                    ),
                    SizedBox(height:15),   // spacer
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 245, 243, 242)),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 1: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 18,
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
                                      fontSize: 18,
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
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                              ]
                            )
                      )
                    ),
                    
                ]
              ),
            ),
          )
          ),
          Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFAAC7C0)),
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
                            "Long Term",
                            style: TextStyle(color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Bai Jamjuree',
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        )
                      )
                    ),
                    SizedBox(height:15),   // spacer
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 245, 243, 242)),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ex 1: \$xx",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 18,
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
                                      fontSize: 18,
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
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                              ]
                            )
                      )
                    ),
                    
                ]
              ),
            ),
          )
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                
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
                          "+ New Goal",
                          style: TextStyle(color: Colors.black,
                            fontSize: 28,
                            fontFamily: 'Bai Jamjuree',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      )
                    )
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height:15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromARGB(255, 245, 243, 242)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right:10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Term Type:",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                SizedBox(width: 25),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // select type
                                    },
                                    child: const Text("Short",
                                      style: TextStyle(color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Bai Jamjuree',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // select type
                                    },
                                    child: const Text("Long",
                                      style: TextStyle(color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Bai Jamjuree',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Title:",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xFFAAC7C0)),
                                    child: TextField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Goal Title...',
                                        border:OutlineInputBorder(borderSide: BorderSide.none,),
                                        hintStyle: TextStyle(fontSize: 12)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Amount:",
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Bai Jamjuree',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xFFAAC7C0)),
                                    child: TextField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Goal Amount...',
                                        border:OutlineInputBorder(borderSide: BorderSide.none,),
                                        hintStyle: TextStyle(fontSize: 12)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                          ]
                        )
                      )
                    ),
                  ]  
                ]
              ),
            ),
          ))
          ),
        ]
      ),    
    )
    );
  }
}