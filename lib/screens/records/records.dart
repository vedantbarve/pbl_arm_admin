import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';

import 'package:pbl_arm_admin/models/record_model.dart';

import 'package:pbl_arm_admin/screens/records/record_details.dart';
import 'package:pbl_arm_admin/services/firebase/records_controller.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
      ),
      body: FutureBuilder(
        future: RecordsController().getRecords(),
        builder: (context, AsyncSnapshot<List<RecordModel>> snapshot) {
          if (snapshot.hasData) {
            List<RecordModel> records = snapshot.data!;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RecordDetailsView(recordModel: record);
                        },
                      ),
                    );
                  },
                  leading: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  title: const Text('Date'),
                  subtitle: Text(
                    (record.timeStamp != null)
                        ? DateTime.parse(record.timeStamp).toHumanString()
                        : 'Null Date And Time',
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
