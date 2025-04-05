import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F3F2), // Set background color to #f5f3f2
        child: const Center(child: Text('Welcome to the Dashboard')),
      ),
    );
  }
}

class LookBackward extends StatelessWidget {
  const LookBackward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F3F2), // Set background color to #f5f3f2
        child: const Center(child: Text('Looking Backward')),
      ),
    );
  }
}

class LookOnward extends StatelessWidget {
  const LookOnward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F3F2), // Set background color to #f5f3f2
        child: const Center(child: Text('Looking Onward')),
      ),
    );
  }
}

class LookForward extends StatelessWidget {
  const LookForward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F3F2), // Set background color to #f5f3f2
        child: const Center(child: Text('Looking Forward')),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F3F2), // Set background color to #f5f3f2
        child: const Center(child: Text('Settings Page')),
      ),
    );
  }
}
