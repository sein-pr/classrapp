import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_navigation_bar.dart';
import 'statistics_page.dart';

class AttendancePage extends StatefulWidget {
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
      appBar: AppBar(
        title: Text('Attendance Tracker'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text('Select Date'),
            
          ),
          Container(
            child:const Align( 
              alignment: Alignment.centerRight,
              child: Text('Weekly Attendance',
            textAlign:TextAlign.right ,
            style: TextStyle(
            color: Colors.white
            ),
            ),
            ),
            
          )
          ,
          Expanded(
            child: Container(color:Colors.white ,
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  final studentName = 'Student ${index + 1}';
                  return ListTile(
                    title: Row(
                      children: [
                        Text(studentName),
                        Spacer(),
                        ...List.generate(
                          4,
                          (checkBoxIndex) => Checkbox(
                            value: _attendanceMap[studentName] != null &&
                                _attendanceMap[studentName]![checkBoxIndex],
                            onChanged: (value) {
                              setState(() {
                                if (_attendanceMap[studentName] == null) {
                                  _attendanceMap[studentName] = List.filled(4, false);
                                }
                                _attendanceMap[studentName]![checkBoxIndex] = value ?? false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
         
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
            child: Text('View Attendance Percentage'),
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
