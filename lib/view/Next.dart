import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'work_on_screen.dart'; // Import the next screen

class NextScreen extends StatefulWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  String selectedFeeling = '';
  int sessionDuration = 30; // Default session duration

  void _navigateToNextScreen(BuildContext context) {
    if (selectedFeeling.isEmpty) {
      // Show an alert if no feeling is selected
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Please select your feeling'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkOnScreen(
          feeling: selectedFeeling,
          duration: sessionDuration,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.purple,
        middle:
            const Text('Next Screen', style: TextStyle(color: Colors.white)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _buildFeelingButton(context, 'Energized', Colors.orange),
                _buildFeelingButton(context, 'Calm', Colors.lightBlue),
                _buildFeelingButton(context, 'Depressed', Colors.grey),
                _buildFeelingButton(context, 'Tired', Colors.brown),
                _buildFeelingButton(context, 'Stressed', Colors.red),
              ],
            ),
            const SizedBox(height: 30.0),
            const Text(
              'How long do you want your session to be?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10.0),
            CupertinoSlidingSegmentedControl<int>(
              backgroundColor: Colors.white.withOpacity(0.2),
              thumbColor: Colors.purple,
              groupValue: sessionDuration,
              onValueChanged: (value) {
                setState(() {
                  sessionDuration = value ?? 30;
                });
              },
              children: const {
                15: Text('15 min', style: TextStyle(color: Colors.purple)),
                30: Text('30 min', style: TextStyle(color: Colors.purple)),
                45: Text('45 min', style: TextStyle(color: Colors.purple)),
                60: Text('60 min', style: TextStyle(color: Colors.purple)),
              },
            ),
            const SizedBox(height: 40.0),
            CupertinoButton(
              color: Colors.purple,
              onPressed: () => _navigateToNextScreen(context),
              child: const Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeelingButton(BuildContext context, String label, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFeeling = label;
        });
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: selectedFeeling == label
              ? color.withOpacity(0.9)
              : color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 5.0,
            ),
          ],
          border: selectedFeeling == label
              ? Border.all(color: Colors.white, width: 3.0)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
