import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'TabsLayout.dart';
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

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
     return tablayout();
      // return RetailerInfo();
    }
    return LoginScreen();
  }
}



