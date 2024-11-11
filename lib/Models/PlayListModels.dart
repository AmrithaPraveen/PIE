class PlayListModel {
  final String songName;
  final String fileURL;
  final int duration;
  final int ragaID;

  PlayListModel({
    required this.songName,
    required this.fileURL,
    required this.duration,
    required this.ragaID,
  });

  factory PlayListModel.fromMap(Map<String, dynamic> map) {
    return PlayListModel(
      songName: map['songName'] ?? '',
      fileURL: map['fileURL'] ?? '',
      duration: int.parse(map['duration']) ?? 0,
      ragaID: int.parse(map['ragaID']) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'songName': songName,
      'fileURL': fileURL,
      'duration': duration,
      'ragaID': ragaID,
    };
  }
}
