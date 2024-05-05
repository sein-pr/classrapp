import 'package:classrapp/utils/app_colors.dart';
import 'package:classrapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/bottom_navigation_bar.dart';

class HomeScreenLecturer extends StatefulWidget {
  const HomeScreenLecturer({super.key});

  @override
  State<HomeScreenLecturer> createState() => _HomeScreenLecturerState();
}

class _HomeScreenLecturerState extends State<HomeScreenLecturer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryGradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Tue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: " 03 May",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            blurRadius: 12,
                            spreadRadius: 8,
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            introImage,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Professor",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "123456789",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 180,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height - 210,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView(
                children: [
                  buildTitleRow("Today's Classes", 3),
                  const SizedBox(height: 20),
                  buildClassItem(),
                  buildClassItem(),
                  buildClassItem(),
                  const SizedBox(
                    height: 25,
                  ),
                  buildTitleRow("Your Tasks", 4),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildAssignItem(
                            3, "Software Engineering", Colors.red, "Cancel"),
                        buildAssignItem(
                            14, "Data Structures", Colors.green, "Cancel"),
                        buildAssignItem(
                            12, "Computer Theories", Colors.green, "Cancel"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildAssignItem(
      int numDays, String courseTitle, Color color, String buttonText) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deadline",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "$numDays days left",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 100,
            child: Text(
              courseTitle,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add cancel functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildClassItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "07:00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              Text(
                "AM",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 160,
                  child: const Text(
                    "Data Structures",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 160,
                        child: const Text(
                          "Venue, Computer Centre",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(introImage),
                      radius: 10,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Mee Kauna",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality to cancel the class
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "($number)",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Text(
              "See All",
              style: TextStyle(fontSize: 14, color: Color(0xFF3E3993)),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                // Add functionality to navigate to a page with all classes/tasks
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Color(0xFF3E3993),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
