import 'package:flutter/cupertino.dart';

class ChallengeConfirmationPage extends StatelessWidget {
  final String dailyChallenge;
  final String longTermChallenge;

  ChallengeConfirmationPage({
    required this.dailyChallenge,
    required this.longTermChallenge,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Challenges Accepted!'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '🎉 Challenges Accepted! 🎉',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Daily Challenge:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              dailyChallenge,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Long-Term Challenge:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              longTermChallenge,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'Keep up the great work! You’re making a positive impact!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page or home
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
