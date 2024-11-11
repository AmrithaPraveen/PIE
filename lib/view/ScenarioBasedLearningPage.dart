import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScenarioBasedLearningPage extends StatefulWidget {
  @override
  _ScenarioBasedLearningPageState createState() =>
      _ScenarioBasedLearningPageState();
}

class _ScenarioBasedLearningPageState extends State<ScenarioBasedLearningPage> {
  int selectedAnswerIndex = -1;
  bool showFeedback = false;
  String feedbackText = '';
  int currentScenarioIndex = 0; // To keep track of the current scenario
  int totalPoints = 0; // To track points earned

  final List<Map<String, dynamic>> scenarios = [
    {
      'scenario':
          'You notice a classmate who seems shy and doesn’t talk much during group activities. How would you approach them?',
      'answers': [
        'Ignore them, they might not want to talk.',
        'Invite them to join the conversation, but don’t pressure them.',
        'Ask them why they are so quiet.',
      ],
      'feedback': [
        'Ignoring someone might make them feel even more left out.',
        'This is a great way to make them feel included without overwhelming them.',
        'Asking directly about their behavior could make them uncomfortable.',
      ],
      'points': 10 // Assign points for completing this scenario
    },
    {
      'scenario':
          'During a group project, one team member is struggling to keep up. What should you do?',
      'answers': [
        'Do all the work yourself to make it easier for them.',
        'Offer to explain the tasks and help them understand.',
        'Complain to the teacher that they are not contributing.',
      ],
      'feedback': [
        'Doing all the work yourself won’t help them learn or feel part of the group.',
        'Offering help is a great way to ensure everyone is included and learns.',
        'Complaining won’t solve the issue and could make them feel bad.',
      ],
      'points': 15 // Points for this scenario
    },
  ];

  void _selectAnswer(int answerIndex) {
    setState(() {
      selectedAnswerIndex = answerIndex;
      feedbackText = scenarios[currentScenarioIndex]['feedback'][answerIndex];
      showFeedback = true;
    });
  }

  void _nextScenario() {
    if (currentScenarioIndex < scenarios.length - 1) {
      setState(() {
        currentScenarioIndex++;
        selectedAnswerIndex = -1;
        showFeedback = false;
      });
    } else {
      // When all scenarios are completed, calculate points
      setState(() {
        totalPoints += (scenarios[currentScenarioIndex]['points'] as int);
        feedbackText =
            'You’ve completed all the scenarios and earned $totalPoints points!';
      });
    }
  }

  void _completeScenario() {
    // Add points for the current scenario and move to the next one
    setState(() {
      totalPoints += (scenarios[currentScenarioIndex]['points'] as int);
      _nextScenario();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> currentScenario =
        scenarios[currentScenarioIndex];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Scenario-Based Learning',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Purple theme for navbar
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          // Wrap in SingleChildScrollView to fix overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Space for adding a picture
              Container(
                height: 200,
                child: Image.asset(
                  'assets/image/scenario1.png', // Adding the image from assets
                  fit: BoxFit.cover, // Ensures the image fits the container
                ),
              ),
              SizedBox(height: 16),

              // Progress Bar
              LinearProgressIndicator(
                value: (currentScenarioIndex + 1) / scenarios.length,
                backgroundColor: Colors.grey[300],
                color: Color(0xFF7E57C2), // Purple progress bar
                minHeight: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A1B9A), // Purple for heading
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      currentScenario['scenario'],
                      style: TextStyle(fontSize: 20, color: Color(0xFF37474F)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'How would you respond?',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF7E57C2)), // Purple subheading
                    ),
                    SizedBox(height: 20),

                    // Display Answers in a Card-Based Layout
                    ...List.generate(
                      currentScenario['answers'].length,
                      (index) => GestureDetector(
                        onTap: () => _selectAnswer(index),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedAnswerIndex == index
                                ? Color(0xFF7E57C2).withOpacity(
                                    0.7) // Selected answer - purple
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedAnswerIndex == index
                                    ? CupertinoIcons.check_mark_circled_solid
                                    : CupertinoIcons.circle,
                                color: selectedAnswerIndex == index
                                    ? Colors.white
                                    : Color(
                                        0xFF7E57C2), // Purple for unselected
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  currentScenario['answers'][index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: selectedAnswerIndex == index
                                        ? Colors.white
                                        : Color(
                                            0xFF37474F), // Black for unselected
                                    fontWeight: selectedAnswerIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (showFeedback)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(
                                0xFFFFF9C4), // Yellow background for feedback
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            feedbackText,
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF37474F)),
                          ),
                        ),
                      ),
                    if (showFeedback)
                      CupertinoButton(
                        color: Color(0xFF6A1B9A), // Purple button
                        onPressed: _completeScenario,
                        child: Text(
                          currentScenarioIndex < scenarios.length - 1
                              ? 'Next Scenario'
                              : 'Complete Scenario',
                          style: TextStyle(fontSize: 18),
                        ),
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
}
