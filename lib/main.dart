import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_services.dart';
import 'mainscreen.dart';

FirebaseFirestore? fStore;
FirebaseAuth? firebaseAuth;

Future<void> main() async {
  FirebaseApp? firestore;
  WidgetsFlutterBinding.ensureInitialized();

  firestore = await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDB9uWGz7bf08gfCb2-jJ4Au6lV2fhkdks',
        appId: '1:1054023516653:web:e37a4443bff6d9e1e4a7e4',
        messagingSenderId: '1054023516653',
        projectId: 'jpsurveywebtesting'),
  );
  fStore = FirebaseFirestore.instanceFor(app: firestore);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: "JP Survey",
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      return FirstTable();
    }
    return MainScreen();
  }
}

class FirstTable extends StatefulWidget {
  @override
  State<FirstTable> createState() => _FirstTable();
}

class _FirstTable extends State<FirstTable> {
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: firebasedata,
      //   child: Icon(Icons.add),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    firebasedata();
  }

  void firebasedata() {
    fStore!.collection("users").get().then((querySnapshot) {
      _rowList.clear();

      querySnapshot.docs.forEach((result) {
        Value1 = (result.data()["Id"]);
        Value2 = (result.data()["Name"]);
        Value3 = (result.data()["TotalRetailers"]);
        Value4 = (result.data()["IceBreaker"]);
        Value5 = (result.data()["Quiz"]);
        Value6 = (result.data()["Ratings"]);

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
}
