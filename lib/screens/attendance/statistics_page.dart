import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class StatisticsPage extends StatelessWidget {
  final Map<String, bool> attendanceMap;
  final DateTime date;

  const StatisticsPage({
    super.key,
    required this.attendanceMap,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final List<bool> attendances = attendanceMap.values.toList();
    final int presentCount = attendances.where((element) => element).length;
    final double averageAttendance = attendances.isEmpty
        ? 0
        : presentCount / attendances.length * 100;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradientColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Attendance Statistics',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Date: ${date.toString().substring(0, 10)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Average Attendance: ${averageAttendance.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
