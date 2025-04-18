import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'settings.dart';
import 'chatbot.dart';
import 'calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 55, 121, 140)),
        useMaterial3: true,
        fontFamily: 'Bai Jamjuree',
      ),
      home: const SplashScreen(), // Set the splash screen as the initial page
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the fade animation
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Start the animation and navigate to MyHomePage after it completes
    Future.delayed(const Duration(seconds: 2), () {
      _controller.forward().then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const MyHomePage(title: 'title'),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 245, 243, 242),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/planit.png', // Ensure this asset exists in your project
                width: 250,
                height: 250,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'PlanIt',
                style: TextStyle(
                  color: Color(0xFF160F29),
                  fontSize: 60,
                  fontFamily: 'Orbitron',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ChatScreen(),
    Dashboard(),
    Calendar(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: const Color.fromARGB(255, 55, 121, 140)),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/past.png'), // Custom dashboard icon
              ),
              label: 'Penny',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/present.png'), // Custom backward icon
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/future.png'), // Custom onward icon
              ),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/settings.png'), // Custom settings icon
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:
              const Color.fromARGB(255, 255, 255, 255), // Deep purple color
          unselectedItemColor: const Color(0xFFAAC7C0), // Light teal color
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
