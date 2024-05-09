import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_navigation_bar.dart';
import 'statistics_page.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _selectedDate = DateTime.now();
  Map<String, List<bool>> _attendanceMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Attendance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    final studentName = _getStudentName(index);
                    return ListTile(
                      title: Row(
                        children: [
                          Text(studentName),
                          const Spacer(),
                          ...List.generate(
                            5,
                            (checkBoxIndex) => Checkbox(
                              value: _attendanceMap[studentName] != null &&
                                  _attendanceMap[studentName]![checkBoxIndex],
                              onChanged: (value) {
                                setState(() {
                                  if (_attendanceMap[studentName] == null) {
                                    _attendanceMap[studentName] =
                                        List.filled(5, false);
                                  }
                                  _attendanceMap[studentName]![checkBoxIndex] =
                                      value ?? false;
                                });
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendancePercentagePage(
                      attendanceMap: _attendanceMap,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('View Attendance Percentage'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _attendanceMap.clear(); // Reset attendance map when date changes
      });
    }
  } 
}

String _getStudentName(int index) {
    switch (index) {
      case 0:
        return 'Alzira Dongua';
      case 1:
        return 'Sein Muwana';
      case 2:
        return 'Raphael Thikusho';
      case 3:
        return 'Victoria Kulula';
      case 4:
        return 'Elritz Kaahangoro';
      case 5:
        return 'Lahya Matheus';
      case 6:
        return 'Michael Pieters';
      case 7:
        return 'Olivia Van Wyk';
      case 8:
        return 'William Petrus';
      case 9:
        return 'Charlotte Louw';
      case 10:
        return 'James Peter';
      case 11:
        return 'Emily Shilongo';
      case 12:
        return 'Daniel Eiseb';
      case 13:
        return 'Ava Elias';
      case 14:
        return 'Liam Beukes';
      default:
        return 'Student ${index + 1}';
    }
  }

