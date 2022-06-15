import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pbl_arm_admin/models/record_model.dart';
import 'package:pbl_arm_admin/models/student_model.dart';

class RecordsController {
  Future<List<RecordModel>> getRecords() async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final data = await firestore
        .collection('records')
        .where('mentorId', isEqualTo: user!.uid)
        .get();

    return data.docs
        .map((doc) => RecordModel.fromMap(doc.data())..recordId = doc.id)
        .toList();
  }

  Future<List<StudentModel>> getStudents(String recordId) async {
    final firestore = FirebaseFirestore.instance;
    var data =
        await firestore.collection('records/$recordId/participants').get();
    return data.docs.map((doc) => StudentModel.fromMap(doc.data())).toList();
  }
}
