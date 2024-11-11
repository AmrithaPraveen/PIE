import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EpicMissionsPage extends StatelessWidget {
  final List<Map<String, String>> epicMissions = [
    {
      'title': 'Lead a Friendship Group',
      'description':
          'Start a lunch group and invite students who usually sit alone to join.',
    },
    {
      'title': 'Organize an Inclusion Event',
      'description':
          'Work with your teacher to host an inclusion event for your school.',
    },
    {
      'title': 'Mentor a Peer',
      'description':
          'Become a peer mentor and help others with schoolwork or social activities.',
    },
    {
      'title': 'Start an Empathy Club',
      'description':
          'Create a club focused on empathy and kindness projects in your community.',
    },
    {
      'title': 'Run a Peer Support Campaign',
      'description':
          'Raise awareness about peer support by creating posters and social media content.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Epic Missions',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Purple theme
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Take on these Epic Missions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A), // Dark purple text
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: epicMissions.length,
                  itemBuilder: (context, index) {
                    return _buildMissionCard(context, epicMissions[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build each mission card with the purple theme
  Widget _buildMissionCard(BuildContext context, Map<String, String> mission) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFEDE7F6), // Light purple background
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.rocket_fill,
                color: Color(0xFF6A1B9A), // Dark purple icon
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                mission['title']!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A), // Dark purple text
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            mission['description']!,
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey, // Muted grey for description
            ),
          ),
          SizedBox(height: 10),
          CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: Color(0xFF6A1B9A), // Dark purple button
            onPressed: () {
              // Action when mission is accepted
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Mission Accepted!'),
                    content: Text('You’ve taken on ${mission['title']}'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Awesome!'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Accept Mission',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
