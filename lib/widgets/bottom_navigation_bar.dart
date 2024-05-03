import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedItemIndex = 0; // Set the initial selected index to 0 (Home)
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.primaryGradientColor[0],
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.white),
      currentIndex: _selectedItemIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "attendence",
          icon: Icon(Icons.insert_chart),
        ),
        BottomNavigationBarItem(
          label: "Assign..",
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
}
