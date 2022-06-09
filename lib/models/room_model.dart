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
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] ?? null,
      mentorName: map['mentorName'] ?? null,
      mentorId: map['mentorId'] ?? null,
      roomLat: map['roomLat'] ?? null,
      roomLong: map['roomLong'] ?? null,
      roomLimit: map['roomLimit'] ?? null,
      subject: map['subject'] ?? null,
      division: map['division'] ?? null,
      batch: map['batch'] ?? null,
      isActive: map['isActive'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));
}
