import 'dart:convert';

class RoomModel {
  dynamic roomId;
  dynamic mentorName;
  dynamic mentorId;
  dynamic roomLat;
  dynamic roomLong;
  dynamic roomLimit;
  dynamic subject;
  dynamic division;
  dynamic batch;
  dynamic isActive;
  dynamic timeStamp;

  RoomModel({
    required this.roomId,
    required this.mentorName,
    required this.mentorId,
    required this.roomLat,
    required this.roomLong,
    this.roomLimit,
    this.subject,
    required this.division,
    required this.batch,
    this.isActive,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'mentorName': mentorName,
      'mentorId': mentorId,
      'roomLat': roomLat,
      'roomLong': roomLong,
      'roomLimit': roomLimit,
      'subject': subject,
      'division': division,
      'batch': batch,
      'isActive': isActive,
      'timeStamp': timeStamp,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'],
      mentorName: map['mentorName'],
      mentorId: map['mentorId'],
      roomLat: map['roomLat'],
      roomLong: map['roomLong'],
      roomLimit: map['roomLimit'],
      subject: map['subject'],
      division: map['division'],
      batch: map['batch'],
      isActive: map['isActive'],
      timeStamp: map['timeStamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));
}
