import 'dart:convert';

class RecordModel {
  dynamic recordId;
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
  RecordModel({
    required this.recordId,
    required this.mentorName,
    required this.mentorId,
    required this.roomLat,
    required this.roomLong,
    required this.roomLimit,
    required this.subject,
    required this.division,
    required this.batch,
    required this.isActive,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
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

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    return RecordModel(
      recordId: map['recordId'],
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

  factory RecordModel.fromJson(String source) =>
      RecordModel.fromMap(json.decode(source));
}
