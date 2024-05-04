import 'package:flutter/material.dart';
import 'package:classrapp/screens/auth/login_screen.dart';
import 'package:classrapp/screens/auth/register_screen.dart';
import 'package:classrapp/screens/home/home_screen.dart';
import 'package:classrapp/utils/constants.dart';
import 'package:classrapp/widgets/splash_loading_indicator.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _selectedDate = DateTime.now();
  Map<String, bool> _attendanceMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Tracker'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text('Select Date'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                final studentName = 'Student ${index + 1}';
                return ListTile(
                  title: Row(
                    children: [
                      Text(studentName),
                      Spacer(),
                      Checkbox(
                        value: _attendanceMap[studentName] ?? false,
                        onChanged: (value) {
                          setState(() {
                            _attendanceMap[studentName] = value!;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticsPage(
                    attendanceMap: _attendanceMap,
                    date: _selectedDate,
                  ),
                ),
              );
            },
            child: Text('View Statistics'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _attendanceMap.clear(); // Reset attendance map when date changes
      });
    }
  }
}

class StatisticsPage extends StatelessWidget {
  final Map<String, bool> attendanceMap;
  final DateTime date;

  StatisticsPage({required this.attendanceMap, required this.date});

  @override
  Widget build(BuildContext context) {
    final List<bool> attendances = attendanceMap.values.toList();
    final int presentCount = attendances.where((element) => element).length;
    final double averageAttendance = attendances.isEmpty
        ? 0
        : presentCount / attendances.length * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Date: ${date.toString().substring(0, 10)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Average Attendance: ${averageAttendance.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}


