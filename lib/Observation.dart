class Observation extends StatefulWidget {
  @override
  State<Observation> createState() => _Observation();
}

class _Observation extends State<Observation> {
  var ObValue1;
  var ObValue2;
  var ObValue3;
  var ObValue4;
  var ObValue5;
  var ObValue6;

  List<DataRow> _rowList2 = [];

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
                    label: Text("Packaging Ratings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                // DataColumn(label: Text(''),),
              ],
              rows: _rowList2)),
    );
  }

  @override
  void initState() {
    super.initState();
    firebasedata();
  }

  Future<void> firebasedata() async {

    fStore!.collection("Observation").get().then((querySnapshot) {
      _rowList2.clear();
      querySnapshot.docs.forEach((result) {
        ObValue1 = (result.data()["autoRetailerId"]);
        ObValue2 = (result.data()["name"]);
        ObValue3 = (result.data()["TotalRetailers"]);
        ObValue4 = (result.data()["IceBreaker"]);
        ObValue5 = (result.data()["Quiz"]);
        ObValue6 = (result.data()["packagingRating"]);

        _rowList2.add(DataRow(cells: <DataCell>[
          // DataCell(Text(Value1 ?? '')),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 150,
              child: Text(ObValue1 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 170,
              child: Text(ObValue2 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 165,
              child: Text(ObValue3 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 200,
              child: Text(ObValue4 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 200,
              child: Text(ObValue5 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
          DataCell(Container(
              constraints: BoxConstraints(maxWidth: 200),
              width: 150,
              child: Text(ObValue6 ?? "", overflow: TextOverflow.ellipsis))),
          // DataCell(VerticalDivider(thickness: 5,)),
        ]));
      });
      setState(() {
        _rowList2 = _rowList2;
      });
    });
  }

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText(ObValue1 ?? "");
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
