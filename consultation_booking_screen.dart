import 'package:flutter/material.dart';

class ConsultationBookingScreen extends StatefulWidget {
  const ConsultationBookingScreen({Key? key}) : super(key: key);

  @override
  _ConsultationBookingScreenState createState() =>
      _ConsultationBookingScreenState();
}

class _ConsultationBookingScreenState extends State<ConsultationBookingScreen> {
  String? selectedLecturer;
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context), // Use the same theme as the parent context
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book Consultation'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Lecturer:',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    DropdownButton<String>(
                      value: selectedLecturer,
                      onChanged: (newValue) {
                        setState(() {
                          selectedLecturer = newValue!;
                        });
                      },
                      items: <String>['Lecturer 1', 'Lecturer 2', 'Lecturer 3']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Select Time Slot:',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    DropdownButton<String>(
                      value: selectedTimeSlot,
                      onChanged: (newValue) {
                        setState(() {
                          selectedTimeSlot = newValue!;
                        });
                      },
                      items: <String>[
                        '9:00 AM - 10:00 AM',
                        '10:00 AM - 11:00 AM',
                        '11:00 AM - 12:00 PM'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        // Implement logic to confirm the booking
                        if (selectedLecturer != null &&
                            selectedTimeSlot != null) {
                          // Perform booking confirmation actions
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Booking Confirmation'),
                                content: Text(
                                    'You have successfully booked a consultation with $selectedLecturer for $selectedTimeSlot.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Show error message if lecturer or time slot is not selected
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please select a lecturer and a time slot.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text('Book Consultation',
                            style: TextStyle(fontSize: 18.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
