import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentFeedbackPage extends StatefulWidget {
  @override
  _StudentFeedbackPageState createState() => _StudentFeedbackPageState();
}

class _StudentFeedbackPageState extends State<StudentFeedbackPage> {
  final _feedbackController = TextEditingController();
  int charCount = 0;

  final List<String> peers = [
    'Alex Johnson',
    'Sophia Martinez',
    'Liam Davis'
  ]; // Example peers
  String selectedPeer = 'Alex Johnson';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Give Feedback',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Purple navigation bar
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a peer to give feedback to:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A)), // Purple heading
            ),
            SizedBox(height: 20),
            _buildPeerSelection(),
            SizedBox(height: 20),
            Text(
              'What do you want to say?',
              style: TextStyle(
                  fontSize: 18, color: Color(0xFF6A1B9A)), // Purple subheading
            ),
            SizedBox(height: 10),
            _buildFeedbackInput(),
            SizedBox(height: 10),
            _buildReactionsRow(),
            SizedBox(height: 20),
            _buildSubmitButton(), // Updated button
          ],
        ),
      ),
    );
  }

  // Build the peer selection with avatars
  Widget _buildPeerSelection() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peers.length,
        itemBuilder: (context, index) {
          String peer = peers[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPeer = peer;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'assets/image/Alex_avatar.png'), // Example image
                  ),
                  SizedBox(height: 5),
                  Text(
                    peer,
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedPeer == peer
                          ? Color(0xFF7E57C2) // Purple for selected
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Build the feedback input with live character count
  Widget _buildFeedbackInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          controller: _feedbackController,
          maxLines: 4,
          placeholder: 'Enter your feedback here...',
          onChanged: (text) {
            setState(() {
              charCount = text.length;
            });
          },
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6), // Light purple input field
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$charCount/200 characters',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Build the reactions row with emojis or icons
  Widget _buildReactionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildReactionButton('👍', 'Encouraging'),
        _buildReactionButton('💬', 'Constructive'),
        _buildReactionButton('🌟', 'Outstanding'),
      ],
    );
  }

  // Create each reaction button
  Widget _buildReactionButton(String emoji, String label) {
    return GestureDetector(
      onTap: () {
        // Optional: Add action when reaction is selected
      },
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 36),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Build the submit feedback button with a purple theme
  Widget _buildSubmitButton() {
    return Center(
      child: Container(
        width: double.infinity,
        child: CupertinoButton(
          color: Color(0xFF6A1B9A), // Dark purple color for button
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          borderRadius: BorderRadius.circular(10),
          child: Text(
            'Submit Feedback',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
            if (_feedbackController.text.isNotEmpty) {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('Feedback Submitted!'),
                    content: Text('You’ve sent feedback to $selectedPeer.'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
