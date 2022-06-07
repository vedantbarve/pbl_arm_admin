import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/room_model.dart';
import '../../models/student_model.dart';

class RoomController {
  Future createRoom(RoomModel room) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.doc('rooms/${room.roomId}').set(room.toMap());
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Stream<QuerySnapshot<StudentModel>> getStudentsAsStream(String roomId) {
    final firestore = FirebaseFirestore.instance;
    var data = firestore
        .collection("rooms/$roomId/participants")
        .withConverter<StudentModel>(
          fromFirestore: (snapshot, _) {
            return StudentModel.fromMap(snapshot.data()!);
          },
          toFirestore: (model, _) {
            return model.toMap();
          },
        )
        .orderBy("rollNo")
        .snapshots();
    return data;
  }

  Future removeUser(String roomId, String ipAddress) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.doc("rooms/$roomId/participants/$ipAddress").delete();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future addUserToRoom(
    String name,
    String rollNo,
    String ipAddress,
    String roomId,
  ) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.doc("rooms/$roomId/participants/$ipAddress").set(
        {
          "name": name,
          "rollNo": rollNo,
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Stream<DocumentSnapshot<RoomModel>> getRoomDataAsStream(String roomId) {
    final firestore = FirebaseFirestore.instance;
    var data = firestore.doc("rooms/$roomId").withConverter<RoomModel>(
      fromFirestore: (snapshot, _) {
        return RoomModel.fromMap(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toMap();
      },
    ).snapshots();
    return data;
  }

  Future<RoomModel?> getRoomData(String roomId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      var roomData = await firestore.doc("rooms/$roomId").get();
      if (roomData.exists) {
        final data = roomData.data();
        return RoomModel.fromMap(data!);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }
}
