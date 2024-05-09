import 'package:classrapp/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:classrapp/screens/home/home_screen.dart';
import 'package:classrapp/utils/constants.dart';
import 'package:classrapp/widgets/splash_loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              introImage,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 32),
            const Text(
              'ClassrAPP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            SplashLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}