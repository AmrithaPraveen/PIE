import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyChallengePage extends StatefulWidget {
  @override
  _DailyChallengePageState createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  int? selectedChallengeIndex;

  final List<String> dailyChallenges = [
    'Invite a classmate who usually sits alone to join your lunch group.',
    'Ask a peer if they need any support with classwork or an activity.',
    'Offer to partner with someone who may need extra help on a group project.',
    'Include someone new in your conversation or activity today.',
    'Make sure everyone in your group understands the instructions before starting an activity.',
    'Speak up if you notice someone being left out or excluded.',
    'Start a conversation with someone who might need help getting involved.',
    'Ask before offering help and respect personal space when assisting others.',
  ];

  final List<IconData> challengeIcons = [
    CupertinoIcons.person_2,
    CupertinoIcons.question_circle,
    CupertinoIcons.group,
    CupertinoIcons.chat_bubble_text,
    CupertinoIcons.info,
    CupertinoIcons.speaker_3,
    CupertinoIcons.conversation_bubble,
    CupertinoIcons.hand_raised,
  ];

  final Color lightPurple = Color(0xFFEDE7F6); // Light purple for all cards

  void _selectChallenge(int index) {
    setState(() {
      selectedChallengeIndex = index; // Update the selected challenge index
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Daily Inclusion Mission',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            Color(0xFF6A1B9A), // Dark purple for the navigation bar
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Color(0xFFF3E5F5), // Light purple background for the page
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your daily mission for inclusion',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A), // Dark purple
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: dailyChallenges.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _selectChallenge(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedChallengeIndex == index
                              ? lightPurple.withOpacity(0.9)
                              : lightPurple.withOpacity(0.7), // Light purple
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              challengeIcons[index],
                              size: 36,
                              color: selectedChallengeIndex == index
                                  ? Colors.black
                                  : Color(
                                      0xFF6A1B9A), // Dark purple for unselected
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                dailyChallenges[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: selectedChallengeIndex == index
                                      ? Colors.black
                                      : Color(
                                          0xFF6A1B9A), // Dark purple for unselected, black for selected
                                  fontWeight: selectedChallengeIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (selectedChallengeIndex != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Color(0xFF6A1B9A), // Dark purple color for button
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () {
                      // Handle challenge submission logic
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Challenge Accepted!'),
                            content: Text(
                                'You have selected: ${dailyChallenges[selectedChallengeIndex!]}'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('OK'),
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
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
