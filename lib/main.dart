import 'package:classrapp/screens/auth/login_screen.dart';
import 'package:classrapp/screens/auth/register_screen.dart';
import 'package:classrapp/screens/home/home_screen.dart';
import 'package:classrapp/screens/splash/splash.dart';
import 'package:flutter/material.dart';

import 'screens/attendance/attendance_screen.dart';
<<<<<<< HEAD
import 'screens/Consultation/consultation_booking_screen.dart';
=======
import 'screens/communication/chat_screen.dart';
import 'screens/home/lecturer_home_screen.dart';
>>>>>>> c5754353b156ab7619c4a14aa6109edf534c801c

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ClassrApp",
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      //Change here to navigate to the desired screen
<<<<<<< HEAD
      initialRoute: '/splash', // Set the initial route
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/attendance': (context) => const AttendanceScreen(),
        '/book_consultation': (context) =>
            const ConsultationBookingScreen(), // Add route for consultation booking screen
      },
=======
      home: AttendancePage(),
>>>>>>> c5754353b156ab7619c4a14aa6109edf534c801c
    );
  }
}
