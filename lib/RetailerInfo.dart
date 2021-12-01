import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'main.dart';

class RetailerInfo extends StatefulWidget {
  @override
  State<RetailerInfo> createState() => _RetailerInfo();
}

class _RetailerInfo extends State<RetailerInfo> {
  var Value1;
  var Value2;
  var Value3;
  var Value4;
  var Value5;
  var Value6;

  List<DataRow> _rowList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: DataTable(
            sortColumnIndex: 0,
            showBottomBorder: true,
            dividerThickness: 5.0,
            sortAscending: true,
            border: TableBorder.all(),
            // border:TableBorder(
            //     horizontalInside: BorderSide(color: Colors.blue.shade400),
            //     right: BorderSide(color: Colors.blue.shade400),),
            columns: [
              DataColumn(
                  label: Text("ID",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              // DataColumn(label: Text(''),),
              DataColumn(
                  label: Text("Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              // DataColumn(label: Text(''),),
              DataColumn(
                  label: Text("Total Retailers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              // DataColumn(label: Text(''),),
              DataColumn(
                  label: Text("Ice Breaker",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              // DataColumn(label: Text(''),),
              DataColumn(
                  label: Text("Quiz",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              // DataColumn(label: Text(''),),
              DataColumn(
                  label: Text("Ratings",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              // DataColumn(label: Text(''),),
            ],
            rows: _rowList),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createExcel,
        child: Text('Create',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firebasedata();
  }

  Future<void> firebasedata() async {
    // var firebaseUser;
    // =  FirebaseAuth.instance.currentUser;

    // firebaseUser = fStore!.collection("Stats").doc().collection("Retailer info");

    // fStore!.collection("Stats").get();
    // fStore!.collection("Retailer info").doc().get();

    fStore!.collection("Users").get().then((querySnapshot) {
      _rowList.clear();
      querySnapshot.docs.forEach((result) {
        Value1 = (result.data()["autoRetailerId"]);
        Value2 = (result.data()["name"]);
        Value3 = (result.data()["TotalRetailers"]);
        Value4 = (result.data()["IceBreaker"]);
        Value5 = (result.data()["Quiz"]);
        Value6 = (result.data()["packagingRating"]);

        _rowList.add(DataRow(cells: <DataCell>[
          // DataCell(Text(Value1 ?? '')),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 150,
              child: Text(Value1 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 170,
              child: Text(Value2 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 165,
              child: Text(Value3 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 200,
              child: Text(Value4 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 200,
              child: Text(Value5 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 150,
              child: Text(Value6 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
        ]));
      });
      setState(() {
        _rowList = _rowList;
      });
    });
  }

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText(Value1 ?? "");
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Jp Survey Summery.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    // fStore!.collection("users").get().then((querySnapshot) {
    //   _rowList.clear();
    //
    //   querySnapshot.docs.forEach((result) {
    //     Value1 = (result.data()["Id"]);
    //     Value2 = (result.data()["Name"]);
    //     Value3 = (result.data()["TotalRetailers"]);
    //     Value4 = (result.data()["IceBreaker"]);
    //     Value5 = (result.data()["Quiz"]);
    //     Value6 = (result.data()["Ratings"]);
    //
    //     _rowList.add(DataRow(cells: <DataCell>[
    //       // DataCell(Text(Value1 ?? '')),
    //       DataCell(Container(
    //           constraints: BoxConstraints(maxWidth: 200),
    //           width: 150,
    //           child: Text(Value1 ?? "", overflow: TextOverflow.ellipsis))),
    //       // DataCell(VerticalDivider(thickness: 5,)),
    //       DataCell(Container(
    //           constraints: BoxConstraints(maxWidth: 200),
    //           width: 170,
    //           child: Text(Value2 ?? "", overflow: TextOverflow.ellipsis))),
    //       // DataCell(VerticalDivider(thickness: 5,)),
    //       DataCell(Container(
    //           constraints: BoxConstraints(maxWidth: 200),
    //           width: 165,
    //           child: Text(Value3 ?? "", overflow: TextOverflow.ellipsis))),
    //       // DataCell(VerticalDivider(thickness: 5,)),
    //       DataCell(Container(
    //           constraints: BoxConstraints(maxWidth: 200),
    //           width: 200,
    //           child: Text(Value4 ?? "", overflow: TextOverflow.ellipsis))),
    //       // DataCell(VerticalDivider(thickness: 5,)),
    //       DataCell(Container(
    //           constraints: BoxConstraints(maxWidth: 200),
    //           width: 200,
    //           child: Text(Value5 ?? "", overflow: TextOverflow.ellipsis))),
    //       // DataCell(VerticalDivider(thickness: 5,)),
    //       DataCell(Container(
    //           constraints: BoxConstraints(maxWidth: 200),
    //           width: 150,
    //           child: Text(Value6 ?? "", overflow: TextOverflow.ellipsis))),
    //       // DataCell(VerticalDivider(thickness: 5,)),
    //     ]));
    //   });
    //   setState(() {
    //     _rowList = _rowList;
    //   });
    // });
  }
}