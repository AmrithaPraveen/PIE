import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ijas/view/About/About.dart';
import 'package:ijas/view/Announcements/Announcement.dart';

import 'IJAS_2024/Ijas.dart';
import 'More/More.dart';
import 'Student/student.dart';
=======
import 'package:pie/view/DailyChallengesPage.dart';
import 'package:pie/view/EpicMissionsPage.dart';
import 'package:pie/view/ScenarioBasedLearningPage.dart';
import 'package:pie/view/PointsDashboardPage.dart';
import 'package:pie/view/StudentFeedbackPage.dart'; // Import the feedback page
>>>>>>> 2a79d88 (pie)



class HomePage extends StatelessWidget {
<<<<<<< HEAD
   HomePage({super.key});

  List pageIndex = [
    AboutPage(),
    IjasPage(),
    AnnouncementPage(),
    StudentPage(),
    MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          activeColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info_circle_fill),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_text_search),
            label: 'IJAS 2024',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.speaker),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            label: 'Student',
          ),BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ellipsis ),
            label: 'More',
          ),
        ],
=======
  final String username;
  final int points;

  HomePage(
      {required this.username, required this.points, required String role});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Be the Change',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // White bold text
          ),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Purple theme for navbar
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $username!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C), // Dark purple
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You have earned $points points',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2), // Lighter purple for points
                ),
              ),
              SizedBox(height: 20),
              // Text(
              //   'Explore your options:',
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Color(0xFF6A1B9A), // Mid-tone purple
              //   ),
              // ),
              // SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    // Daily Challenge Card
                    _buildMenuCard(
                      context,
                      icon: CupertinoIcons.calendar,
                      title: 'Daily Mission',
                      description: 'Complete today\'s inclusion mission!',
                      backgroundColor: Color(0xFFEDE7F6), // Light lavender
                      iconColor: Color(0xFF4A148C), // Dark purple for icon
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DailyChallengePage()),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    _buildMenuCard(
                      context,
                      icon: CupertinoIcons.time,
                      title: 'Epic Missions',
                      description: 'Work on a long-term goal for inclusion.',
                      backgroundColor: Color(0xFFD1C4E9), // Light purple
                      iconColor: Color(0xFF6A1B9A), // Mid-tone purple
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EpicMissionsPage()),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    // Scenario-Based Learning Card
                    _buildMenuCard(
                      context,
                      icon: CupertinoIcons.book,
                      title: 'Scenario-Based Learning',
                      description: 'Learn through real-life scenarios.',
                      backgroundColor: Color(0xFFC5CAE9), // Light blue-purple
                      iconColor: Color(0xFF5C6BC0), // Mid-blue purple
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  ScenarioBasedLearningPage()),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    // Points Dashboard Card
                    _buildMenuCard(
                      context,
                      icon: CupertinoIcons.chart_bar,
                      title: 'Scoreboard',
                      description: 'Track your progress and earn rewards.',
                      backgroundColor: Color(0xFFE8EAF6), // Very light purple
                      iconColor: Color(0xFF512DA8), // Darker purple for icon
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PointsDashboardPage(
                                    totalPoints: 50,
                                  )),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    _buildMenuCard(
                      context,
                      icon: CupertinoIcons.chat_bubble_2_fill,
                      title: 'Give Feedback',
                      description: 'Provide feedback to another student.',
                      backgroundColor: Color(0xFFF3E5F5), // Light lavender
                      iconColor: Color(0xFF9C27B0), // Vivid purple
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => StudentFeedbackPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom function to build accessible menu cards
  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: iconColor),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C), // Dark purple
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7E57C2), // Mid-tone purple
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
>>>>>>> 2a79d88 (pie)
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return pageIndex[index];
          },
        );
      },
    );
  }
}
