import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'RetailerInfo.dart';
import 'auth_services.dart';
import 'LoginScreen.dart';

FirebaseFirestore? fStore;
FirebaseAuth? firebaseAuth;

Future<void> main() async {
  FirebaseApp? firestore;
  WidgetsFlutterBinding.ensureInitialized();

  firestore = await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyBRtGRdrTuTdLq3Kz6bBBGkJj3ZP3TKQoE',
        appId: '1:1032163161440:web:d37852b174779aa31bda05',
        messagingSenderId: '1032163161440',
        projectId: 'johanplayer-surveyapp'),
  );
  fStore = FirebaseFirestore.instanceFor(app: firestore);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.read<AuthService>().authStateChanges,),
      ],

      child: MaterialApp(
        title: "JP Survey",
        home: AuthWrapper(),
      ),

    );

  }
}

// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: "JP Survey",
//     home: DefaultTabController(
//         length: 2,
//         initialIndex: 0,
//         child:Scaffold(
//           appBar: AppBar(
//             title: Text("Johan Player"),
//             bottom: TabBar(
//               tabs: <Widget>[
//                 Tab(text: "RetailerInfo",),
//                 Tab(text: "Observation",)
//               ],
//
//             ),
//           ),
//           body: TabBarView(
//             children: <Widget>[
//               RetailerInfo(),
//               Observation(),
//             ],
//           ),
//         )
//     ),
//   );
// }
class tablayout extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _tablayout();
}

class _tablayout extends State<tablayout>{

  @override
Widget build(BuildContext context) {
  return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child:Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(50), // here the desired height
          //   child:AppBar(
            // centerTitle: true,
            // title: Text("Johan Player"),
            body: TabBar(
              // isScrollable: true,
              tabs: <Widget>[
                new Container(
                    height: 100.0,
                    child: new Tab(text: "RetailerInfo",)
                ),
                new Container(
                    height: 100.0,
                    child: new Tab(text: "Observation",)
                )
              ],

            ),
          // ),
          // ),
          bottomNavigationBar:TabBarView(
              children: <Widget>[
                RetailerInfo(),
                Observation(),
              ],
            ),
          ),
        );
}
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      // MaterialApp(
      //   home: DefaultTabController(
      //     length: 2,
      //     initialIndex: 0,
      //     child: Scaffold(
      //       appBar: AppBar(
      //         title: Text("Johan Player"),
      //         bottom: TabBar(
      //           tabs: <Widget>[
      //             Tab(text: "RetailerInfo",),
      //             Tab(text: "Observation",)
      //           ],
      //         ),
      //       ),
      //       body: TabBarView(
      //         children: <Widget>[
      //           RetailerInfo(),
      //           Observation(),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
     return tablayout();
      // return RetailerInfo();
    }
    return LoginScreen();
  }
}



