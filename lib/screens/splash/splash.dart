import 'package:classrapp/screens/attendance/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:classrapp/screens/auth/login_screen.dart';
import 'package:classrapp/screens/auth/register_screen.dart';
import 'package:classrapp/screens/home/home_screen.dart';
import 'package:classrapp/screens/Consultation/consultation_booking_screen.dart'; // Import the consultation booking screen
import 'package:classrapp/utils/constants.dart';
import 'package:classrapp/widgets/splash_loading_indicator.dart';

import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  void _navigateToHomeScreen() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const AttendanceScreen(), //Change here to navigate to the desired screen after the intro screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClassrAPP'),
        actions: [
          IconButton(
            icon:
                Icon(Icons.event_note), // Add an icon for booking consultation
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/book_consultation');
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradientColor,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    introImage,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'ClassrAPP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: SplashLoadingIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
