import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointsDashboardPage extends StatelessWidget {
  final int totalPoints; // Pass the total points earned by the user

  PointsDashboardPage({required this.totalPoints});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Points Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Purple themed navbar
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Motivational text and image
              Center(
                child: Column(
                  children: [
                    Text(
                      'Keep up the great work!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A), // Purple for text
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You are an Inclusion Ambassador!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF7E57C2), // Darker purple for text
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/image/badge.png', // Add your image path
                      height: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A), // Purple for headers
                ),
              ),
              SizedBox(height: 20),

              // Display total points earned
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFD1C4E9), // Light purple background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFF6A1B9A), // Purple border
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Points Earned:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A), // Purple for text
                      ),
                    ),
                    Text(
                      '$totalPoints',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7E57C2), // Darker purple for points
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Add a progress bar to show progress toward a milestone
              Text(
                'Progress to Next Badge:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: totalPoints / 100, // Example: milestone at 100 points
                backgroundColor: Colors.grey[300],
                color: Color(0xFF7E57C2), // Purple progress bar
                minHeight: 10,
              ),
              SizedBox(height: 20),
              Text(
                'You are 50% of the way to earning your next badge!',
                style: TextStyle(
                    fontSize: 18, color: Color(0xFF6A1B9A)), // Purple text
              ),
              SizedBox(height: 30),

              // Optionally, show badges for certain milestones
              Text(
                'Earned Badges:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _buildBadge('Beginner', totalPoints >= 20,
                      Color(0xFFF48FB1)), // Light pink badge
                  _buildBadge('Champion', totalPoints >= 50,
                      Color(0xFF7E57C2)), // Purple badge
                  _buildBadge('Ambassador', totalPoints >= 100,
                      Color(0xFFAB47BC)), // Deep purple badge
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to display badges based on points
  Widget _buildBadge(String label, bool earned, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: earned ? color.withOpacity(0.8) : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            earned
                ? CupertinoIcons.check_mark_circled_solid
                : CupertinoIcons.circle,
            size: 36,
            color: earned ? Colors.white : Colors.grey,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: earned ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
