import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playlist_screen.dart'; // Import the playlist screen

class WorkOnScreen extends StatelessWidget {
  final String feeling;
  final int duration;

  const WorkOnScreen({Key? key, required this.feeling, required this.duration})
      : super(key: key);

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
            Text(
              'You are feeling $feeling',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'What do you want to work on?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _buildWorkOnButton(context, CupertinoIcons.moon, 'Sleep'),
                _buildWorkOnButton(
                    context, CupertinoIcons.book, 'Concentration'),
                _buildWorkOnButton(
                    context, CupertinoIcons.wand_stars, 'Relaxation'),
                _buildWorkOnButton(context, CupertinoIcons.heart, 'Love'),
                _buildWorkOnButton(
                    context, CupertinoIcons.bolt, 'New Beginning'),
                _buildWorkOnButton(context, CupertinoIcons.smiley, 'Mood Lift'),
                _buildWorkOnButton(context, CupertinoIcons.house, 'Comfort'),
                _buildWorkOnButton(
                    context, CupertinoIcons.refresh, 'Rejuvenate'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkOnButton(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlaylistScreen(
                  feeling: feeling, activity: label, duration: duration)),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 80,
            color: Colors.purple,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
