import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:pie/Models/PlayListModels.dart'; // Import the model

class RagaProvider extends ChangeNotifier {
  List<PlayListModel> playList = [];
  bool isLoading = false;
  int selectedIndex = 0;

  changeHomeIndex(int val) {
    selectedIndex = val;
    notifyListeners();
  }

  Future<void> getPlayList(
      String feeling, String activity, int duration) async {
    isLoading = true;
    notifyListeners();
    print(
        "Fetching playlist for feeling: $feeling, activity: $activity, duration: $duration");

    final databaseReference = FirebaseDatabase.instance
        .ref()
        .child('1HwIJ2L31dYfQmv-JuCzU4T81LeT9V7ayodwkf-_ytIE');

    try {
      // Fetch Raga IDs that match the feeling
      List<int> ragaIds = [];
      final ragaSnapshot = await databaseReference.child('ragas').get();
      final ragaList = _parseSnapshot(ragaSnapshot);
      print("Ragas fetched: $ragaList");

      if (ragaList != null) {
        ragaList.forEach((key, value) {
          print("Value: $value, Key: $key");

          if (value != null && value['Feeling'] == feeling) {
            ragaIds.add(int.parse(key.toString()));
          }
        });
      }

      print("Matching Raga IDs: $ragaIds");

      // Fetch Songs that match the Raga IDs, activity, and filter by duration
      List<Map<String, String>> songs = [];
      final songSnapshot = await databaseReference.child('songs').get();
      final songList = _parseSnapshot(songSnapshot);
      print("Songs fetched: $songList");

      if (songList != null) {
        for (var ragaId in ragaIds) {
          final matchesActivity = await _isActivityMatch(ragaId, activity);
          print("MATCHED");
          if (matchesActivity) {
            songList.forEach((key, value) {
              if (key != null && key != 0) {
                if (value != null && value['RagaID'] == ragaId) {
                  print("ADD");
                  print(value['Duration']);

                  songs.add({
                    'songName': value['SongName'],
                    'fileURL': value['FileURL'],
                    'duration': value['Duration'].toString(),
                    'ragaID': value['RagaID'].toString(),
                  });
                  print("OUT");
                }
              }
            });
          }
        }
      }

      print("Filtered Songs: $songs");

      // Convert songs to your model
      playList = songs.map((song) => PlayListModel.fromMap(song)).toList();
      print("Playlist Model: $playList");

      // Filter songs by duration
      int totalDuration = 0;
      List<PlayListModel> filteredPlayList = [];
      for (var song in playList) {
        // Assuming each song has a duration in seconds
        int songDuration = song
            .duration; // You need to add the duration field in your PlayListModel
        if (totalDuration + songDuration <= duration * 60) {
          filteredPlayList.add(song);
          totalDuration += songDuration;
        } else {
          break;
        }
      }
      playList = filteredPlayList;
    } catch (e) {
      log('Error fetching playlist: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> _isActivityMatch(int ragaID, String activity) async {
    final databaseReference = FirebaseDatabase.instance
        .ref()
        .child('1HwIJ2L31dYfQmv-JuCzU4T81LeT9V7ayodwkf-_ytIE');
    bool match = false;

    final ragaActivitySnapshot =
        await databaseReference.child('ragaactivity').get();
    final ragaActivityList = _parseSnapshot(ragaActivitySnapshot);

    if (ragaActivityList != null) {
      ragaActivityList.forEach((key, value) {
        if (value != null &&
            value['RagaID'] == ragaID &&
            value['ActivityID'] == _getActivityID(activity)) {
          match = true;
        }
      });
    }

    print("Raga ID $ragaID matches activity $activity: $match");
    return match;
  }

  int _getActivityID(String activity) {
    switch (activity) {
      case 'Sleep':
        return 1;
      case 'Concentration':
        return 2;
      case 'Relaxation':
        return 3;
      case 'Love':
        return 4;
      case 'New Beginning':
        return 5;
      case 'Mood Lift':
        return 6;
      case 'Comfort':
        return 7;
      case 'Rejuvenate':
        return 8;
      default:
        return 0;
    }
  }

  Map<dynamic, dynamic>? _parseSnapshot(DataSnapshot snapshot) {
    if (snapshot.value is Map) {
      return snapshot.value as Map<dynamic, dynamic>;
    } else if (snapshot.value is List) {
      return Map<dynamic, dynamic>.fromIterable(
        (snapshot.value as List).asMap().entries,
        key: (entry) => entry.key,
        value: (entry) => entry.value,
      );
    } else {
      print('Unknown data type or null value received.');
      return null;
    }
  }
}
