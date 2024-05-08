import 'package:classrapp/screens/auth/login_screen.dart';
import 'package:classrapp/screens/auth/register_screen.dart';
import 'package:classrapp/screens/home/home_screen.dart';
import 'package:classrapp/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'screens/attendance/attendance_screen.dart';
import 'screens/communication/chat_screen.dart';
import 'screens/home/lecturer_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = "My app id";
  final keyClientKey = "My Client key";
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //removed the debugg banner
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
      home: LoginScreen(),
    );
  }
}
