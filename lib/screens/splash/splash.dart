import 'package:flutter/material.dart';
import 'package:classrapp/screens/auth/login_screen.dart';
import 'package:classrapp/screens/auth/register_screen.dart';
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
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF536976),
              Color(0xFF292e49),
            ],
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
            Positioned(
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
