import 'dart:io';
import 'package:dart_date/dart_date.dart';
//import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pbl_arm_admin/models/record_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../models/student_model.dart';

class SheetsController {
  Future<void> createAttendance(
    RecordModel recordModel,
    List<StudentModel> students,
  ) async {
    final appDownPath = await getExternalStorageDirectory();
    String appDocPath = appDownPath!.path;
    int index = 7;

    String fileName = DateTime.parse(recordModel.timeStamp).toHumanString();

    var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      await Permission.storage.request();
    }
    var excel = Excel.createExcel();
    Sheet sheet = excel[fileName];

    var mentorCell = sheet.cell(CellIndex.indexByString('A1'));
    mentorCell.value = 'Mentor Name : ${recordModel.mentorName}';

    var classCell = sheet.cell(CellIndex.indexByString('A2'));
    classCell.value = 'Division : ${recordModel.division}';

    var batchCell = sheet.cell(CellIndex.indexByString('A3'));
    batchCell.value = 'Batch : ${recordModel.batch}';

    var timeStampCell = sheet.cell(CellIndex.indexByString('A4'));
    timeStampCell.value =
        'Batch : ${DateTime.parse(recordModel.timeStamp).toHumanString()}';

    var rollNoCell = sheet.cell(CellIndex.indexByString('B6'));
    rollNoCell.value = 'RollNo';

    var statusCell = sheet.cell(CellIndex.indexByString('C6'));
    statusCell.value = 'Status';

    //write rollNo. to the sheet
    int r = 1;
    while (r < 76) {
      var cellData = sheet.cell(CellIndex.indexByString('B${r + 7}'));
      String rollNo;
      var division = recordModel.division[3];
      if (r.toString().length == 1) {
        rollNo = '0$r';
      } else {
        rollNo = r.toString();
      }
      cellData.value = '10$division$rollNo';
      r += 1;
    }

    //mark every student as absent
    int i = 1;
    while (i < 76) {
      var cellData = sheet.cell(CellIndex.indexByString('C${i + 7}'));
      cellData.value = 'A';
      cellData.cellStyle = CellStyle(fontColorHex: '#D2042D');
      i += 1;
    }

    //mark present students only
    for (var student in students) {
      for (int k = 1; k < 76; k++) {
        var cellData = sheet.cell(CellIndex.indexByString('B${k + 7}'));
        if (cellData.value.toString() == student.rollNo.toString().trim()) {
          var statusData = sheet.cell(CellIndex.indexByString('C${k + 7}'));
          statusData.value = 'P';
          statusData.cellStyle = CellStyle(fontColorHex: '#008000');
        }
      }

      var data = excel.encode();

      await File('$appDocPath/$fileName.xlsx').writeAsBytes(data!);
    }
  }
}
