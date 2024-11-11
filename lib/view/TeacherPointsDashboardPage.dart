import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherPointsDashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {
      'name': 'Alex Johnson',
      'points': 130,
    },
    {
      'name': 'Sophia Martinez',
      'points': 120,
    },
    {
      'name': 'Liam Davis',
      'points': 110,
    },
    {
      'name': 'Emily Garcia',
      'points': 95,
    },
    {
      'name': 'Noah Smith',
      'points': 80,
    },
  ];

  final List<String> insights = [
    '5 students invited a peer for lunch.',
    '3 students helped their classmates with homework.',
    '4 students partnered with a peer for a group project.',
    '6 students included new students in activities.',
  ]; // Static insights

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Class of Ms. Yang',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Purple theme for the app
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student Progress Leaderboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A), // Dark purple heading
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(students[index]);
                  },
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Color(0xFF6A1B9A), thickness: 2), // Divider line
              SizedBox(height: 10),
              Text(
                'Recent Class Inclusion Activities',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 10),
              _buildInsightsList(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build individual student cards with a purple theme
  Widget _buildStudentCard(Map<String, dynamic> student) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE1BEE7), // Light purple background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF6A1B9A), // Dark purple border
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.person_fill,
            color: Color(0xFF7E57C2), // Purple icon color
            size: 30,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              student['name'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C), // Dark purple text color
              ),
            ),
          ),
          Text(
            '${student['points']} pts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7E57C2), // Purple points color
            ),
          ),
        ],
      ),
    );
  }

  // Method to build the insights list
  Widget _buildInsightsList() {
    return Column(
      children: insights.map((insight) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.star_fill,
                color: Color(0xFF6A1B9A), // Purple star icon
                size: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  insight,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A148C), // Dark purple text
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
