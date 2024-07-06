import 'package:classrapp/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../screens/attendance/attendance_screen.dart';
import '../screens/communication/chat_screen.dart';
import '../screens/communication/consultation_booking_screen.dart';
import '../screens/home/lecturer_home_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final String userName;
  final String idno;

  const BottomNavigationBarWidget({super.key, required this.userName, required this.idno});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      unselectedItemColor: AppColors.primaryGradientColor[0],
      selectedItemColor: const Color(0xFF536976),
      selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
      currentIndex: _selectedItemIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _selectedItemIndex = index;
        });
        _navigateToScreen(index);
      },
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Attendance",
          icon: Icon(Icons.insert_chart),
        ),
        BottomNavigationBarItem(
          label: "Consultation",
          icon: Icon(Icons.done),
        ),
        BottomNavigationBarItem(
          label: "Today",
          icon: Icon(Icons.calendar_today),
        ),
        BottomNavigationBarItem(
          label: "Chat",
          icon: Icon(Icons.chat_bubble),
        ),
      ],
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenLecturer()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ConsultationBookingScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(userName: widget.userName, idno: widget.idno)),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
        break;
    }
  }
}
