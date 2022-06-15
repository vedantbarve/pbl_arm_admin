import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:pbl_arm_admin/models/record_model.dart';
import 'package:pbl_arm_admin/services/device/sheets_controller.dart';
import 'package:pbl_arm_admin/services/firebase/records_controller.dart';

import '../../models/student_model.dart';

class RecordDetailsView extends StatefulWidget {
  final RecordModel recordModel;

  const RecordDetailsView({Key? key, required this.recordModel})
      : super(key: key);

  @override
  State<RecordDetailsView> createState() => _RecordDetailsViewState();
}

class _RecordDetailsViewState extends State<RecordDetailsView> {
  bool expanded = false;
  final _sheet = SheetsController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RecordsController().getStudents(widget.recordModel.recordId),
      builder: (context, AsyncSnapshot<List<StudentModel>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey[200],
              onPressed: () async {
                try {
                  await _sheet
                      .createAttendance(widget.recordModel, snapshot.data!)
                      .then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Spreadsheet downloaded successfully'),
                        ),
                      );
                    },
                  );
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
              child: Image.asset(
                'assets/images/excel_icon.png',
                height: 30,
              ),
            ),
            body: Column(
              children: [
                ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() => expanded = !expanded);
                  },
                  elevation: 0,
                  children: [
                    ExpansionPanel(
                      isExpanded: expanded,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: const Text('Date and Time:'),
                          subtitle: Text(
                              DateTime.parse(widget.recordModel.timeStamp)
                                  .toHumanString()),
                        );
                      },
                      body: Column(
                        children: [
                          ListTile(
                            title: const Text('Mentor name :'),
                            subtitle: Text(widget.recordModel.mentorName),
                          ),
                          ListTile(
                            title: const Text('Subject :'),
                            subtitle: Text(widget.recordModel.subject),
                          ),
                          ListTile(
                            title: const Text('Total students:'),
                            subtitle: Text("${snapshot.data!.length}"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Text(
                  'List of students ',
                  style: TextStyle(fontSize: 26),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://avatars.dicebear.com/api/human/:$index.png',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        title: Text("${snapshot.data![index].name}"),
                        subtitle:
                            Text("Roll No. ${snapshot.data![index].rollNo}"),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
