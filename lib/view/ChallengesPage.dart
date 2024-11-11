import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie/view/ChallengeConfirmationPage.dart'; // Assume you have a LoginPage to navigate to

class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  String selectedDailyChallenge = 'Select Daily Challenge';
  String selectedLongTermChallenge = 'Select Long-Term Challenge';

  final List<String> dailyChallenges = [
    'Help a classmate with homework.',
    'Include someone new at lunch.',
    'Compliment a friend or classmate.',
    'Spend time with someone who is alone.',
  ];

  final List<String> longTermChallenges = [
    'Organize an inclusion event in your school.',
    'Plan a charity fundraiser for a cause.',
    'Start a kindness challenge for your friends.',
    'Create a presentation about inclusion for your class.',
  ];

  // Function to open action sheet and select challenges
  void _selectChallenge(bool isDaily) {
    final List<String> challenges =
        isDaily ? dailyChallenges : longTermChallenges;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
            isDaily ? 'Select Daily Challenge' : 'Select Long-Term Challenge'),
        actions: challenges
            .map(
              (challenge) => CupertinoActionSheetAction(
                child: Text(challenge),
                onPressed: () {
                  setState(() {
                    if (isDaily) {
                      selectedDailyChallenge = challenge;
                    } else {
                      selectedLongTermChallenge = challenge;
                    }
                  });
                  Navigator.pop(
                      context); // Close the action sheet after selection
                },
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context); // Close without selecting
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Inclusive Challenges'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Daily Challenge Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.activeBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Daily Inclusive Challenge',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CupertinoButton(
                      child: Text(
                        selectedDailyChallenge,
                        style: TextStyle(fontSize: 18),
                      ),
                      color: CupertinoColors.activeBlue,
                      onPressed: () {
                        _selectChallenge(
                            true); // Open daily challenge selection
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Long-Term Challenge Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Long-Term Inclusive Challenge',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CupertinoButton(
                      child: Text(
                        selectedLongTermChallenge,
                        style: TextStyle(fontSize: 18),
                      ),
                      color: CupertinoColors.systemOrange,
                      onPressed: () {
                        _selectChallenge(
                            false); // Open long-term challenge selection
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ChallengeConfirmationPage(
                        dailyChallenge: selectedDailyChallenge,
                        longTermChallenge: selectedLongTermChallenge,
                      ),
                    ),
                  );
                },
                child: Text('Accept Challenges'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
