import 'package:flutter/material.dart';
import 'package:pbl_arm_admin/models/room_model.dart';
import 'package:pbl_arm_admin/services/device/location_controller.dart';
import 'package:pbl_arm_admin/services/firebase/room_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:dart_date/dart_date.dart';
import 'package:beamer/beamer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _mentorName = TextEditingController();
  final _roomCode = TextEditingController();
  final _dateAndTime = TextEditingController();
  final _subject = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int divisionDropDownValue = 1;
  int batchDropDownValue = 1;
  @override
  void initState() {
    super.initState();
    GetLocation().requestLocationPermission();
    _dateAndTime.text = DateTime.now().toHumanString();
    _roomCode.text = const Uuid().v4().substring(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "PICT ATTENDANCE ADMIN",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                  ),
                  child: Text(
                    'Mentor Name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    controller: _mentorName,
                    decoration: InputDecoration(
                      labelText: 'Mentor Name',
                      hintText: 'Mentor Name',
                      contentPadding: const EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                  ),
                  child: Text(
                    'Generate Room Code',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    controller: _roomCode,
                    decoration: InputDecoration(
                      labelText: 'Room Code',
                      hintText: 'Room Code',
                      contentPadding: const EdgeInsets.all(8.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          final uid = const Uuid().v4();
                          setState(() {
                            _roomCode.text = uid.substring(0, 5);
                          });
                        },
                        icon: const Icon(Icons.refresh_rounded),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                  ),
                  child: Text(
                    'Date & Time',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    controller: _dateAndTime,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Date & Time',
                      hintText: 'Date & Time',
                      contentPadding: const EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                  ),
                  child: Text(
                    'Subject',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _subject,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      hintText: 'Subject',
                      contentPadding: const EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                          ),
                          child: Text(
                            'Division',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownButton<int>(
                          value: divisionDropDownValue,
                          items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text("FE $value"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => divisionDropDownValue = value!);
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            left: 8.0,
                          ),
                          child: Text(
                            'Batch',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButton<int>(
                          value: batchDropDownValue,
                          items: <int>[1, 2, 3]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text("$value"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => batchDropDownValue = value!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final userLocation =
                          await GetLocation().getUserLocation();
                      if (_formKey.currentState!.validate()) {
                        await RoomController()
                            .createRoom(
                          RoomModel(
                            roomId: _roomCode.text,
                            mentorName: _mentorName.text,
                            mentorId: '',
                            roomLat: userLocation!['latitude'],
                            roomLong: userLocation['longitude'],
                            subject: _subject.text,
                            roomLimit: 75,
                            isActive: true,
                          ),
                        )
                            .then(
                          (value) {
                            context.beamToReplacementNamed(
                              '/room/${_roomCode.text}',
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Create room'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
