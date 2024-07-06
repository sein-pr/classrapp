import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AttendancePercentagePage extends StatelessWidget {
  final Map<String, List<bool>> attendanceMap;

  AttendancePercentagePage({required this.attendanceMap});

  @override
  Widget build(BuildContext context) {
    final List<int> percentages = attendanceMap.entries.map((entry) {
      final studentAttendance = entry.value;
      final int checkedCount =
          studentAttendance.where((attended) => attended).length;
      if (checkedCount == 0) {
        return 0;
      } else {
        return (checkedCount / studentAttendance.length * 100).round();
      }
    }).toList();

    final double totalPercentage = percentages.isEmpty
        ? 0
        : percentages.reduce((value, element) => value + element) /
            percentages.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Attendance Percentage'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        itemCount: attendanceMap.length,
        itemBuilder: (BuildContext context, int index) {
          final studentName = attendanceMap.keys.toList()[index];
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$studentName'),
                Text('${percentages[index]}%'),
              ],
            ),
            // You can add more customization or icons here based on attendance status
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Average Weekly Attendance: ${totalPercentage.toStringAsFixed(2)}%',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
