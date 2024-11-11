import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pie/Provider/RagaProvider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class PlaylistScreen extends StatefulWidget {
  final String feeling;
  final String activity;
  final int duration; // Add duration parameter

  const PlaylistScreen(
      {Key? key,
      required this.feeling,
      required this.activity,
      required this.duration})
      : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final Map<int, AudioPlayer> _audioPlayers = {};
  final Map<int, bool> _isPlaying = {};
  String ragaDescription = ''; // Variable to hold the raga description

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ragaProvider = Provider.of<RagaProvider>(context, listen: false);
      print(
          "Calling getPlayList for feeling: ${widget.feeling}, activity: ${widget.activity}, duration: ${widget.duration}");
      ragaProvider
          .getPlayList(widget.feeling, widget.activity, widget.duration)
          .then((_) {
        setState(() {
          // Assuming ragaProvider stores the description of the first raga in the list
          if (ragaProvider.playList.isNotEmpty) {
            final firstRagaId = ragaProvider.playList.first.ragaID;
            _fetchRagaDescription(firstRagaId);
          }
        });
      }); // Pass duration
    });
  }

  void _fetchRagaDescription(int ragaId) async {
    print("RAGRA");
    print(ragaId);
    final databaseReference = FirebaseDatabase.instance
        .ref()
        .child('1HwIJ2L31dYfQmv-JuCzU4T81LeT9V7ayodwkf-_ytIE/ragas/$ragaId');
    final ragaSnapshot = await databaseReference.get();
    if (ragaSnapshot.exists) {
      setState(() {
        ragaDescription = ragaSnapshot.child('Description').value as String;
      });
    } else {
      print('Raga description not found.');
    }
  }

  @override
  void dispose() {
    // Dispose all audio players
    _audioPlayers.forEach((key, audioPlayer) {
      audioPlayer.dispose();
    });
    super.dispose();
  }

  Future<String?> getDownloadUrl(String filePath) async {
    final storageRef = FirebaseStorage.instance.ref().child(filePath);
    try {
      final downloadUrl = await storageRef.getDownloadURL();
      print('Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error getting download URL: $e');
      return null;
    }
  }

  void _togglePlayPause(int index, String url) async {
    final audioPlayer = _audioPlayers[index] ?? AudioPlayer();
    if (_isPlaying[index] == true) {
      await audioPlayer.pause();
      setState(() {
        _isPlaying[index] = false;
      });
    } else {
      await audioPlayer.play(UrlSource(url));
      setState(() {
        _isPlaying[index] = true;
      });
    }
    _audioPlayers[index] = audioPlayer;
  }

  @override
  Widget build(BuildContext context) {
    final ragaProvider = Provider.of<RagaProvider>(context);
    print("Building PlaylistScreen");

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Playlist'),
      ),
      child: ragaProvider.isLoading
          ? Center(child: CupertinoActivityIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: ragaProvider.playList.length,
                    itemBuilder: (context, index) {
                      final song = ragaProvider.playList[index];

                      return FutureBuilder<String?>(
                        future: getDownloadUrl(
                            song.fileURL), // Get the download URL
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CupertinoActivityIndicator());
                          } else if (snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data == null) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(song.songName),
                                  Icon(CupertinoIcons.exclamationmark_triangle,
                                      color: CupertinoColors.systemRed),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(song.songName),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      _togglePlayPause(index,
                                          snapshot.data!); // Toggle play/pause
                                    },
                                    child: Icon(
                                      _isPlaying[index] == true
                                          ? CupertinoIcons.pause_solid
                                          : CupertinoIcons.play_arrow_solid,
                                      color: CupertinoColors.systemPurple,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Raga Description',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.systemPurple,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              ragaDescription,
                              style: TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
