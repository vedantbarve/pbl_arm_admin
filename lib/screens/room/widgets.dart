import 'package:flutter/material.dart';
import 'package:pbl_arm_admin/services/firebase/room_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:beamer/beamer.dart';

class AddStudent extends StatefulWidget {
  final String roomId;
  const AddStudent({Key? key, required this.roomId}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final rollNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(
          top: 8.0,
          left: 8.0,
        ),
        child: Text(
          'Add student',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                  contentPadding: const EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                controller: rollNo,
                decoration: InputDecoration(
                  labelText: 'RollNo.',
                  hintText: 'RollNo.',
                  contentPadding: const EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('Add Student'),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await RoomController().addUserToRoom(
                      name.text,
                      rollNo.text,
                      const Uuid().v4(),
                      widget.roomId,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
