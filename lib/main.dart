import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'JP_Survey/TabsLayout.dart';
import 'JP_Survey/auth_services.dart';
import 'JP_Survey/LoginScreen.dart';

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
  // void main() {
  //   runApp(MaterialApp(
  //     title: 'Flutter Tutorial',
  //     home: MyApp(),
  //     debugShowCheckedModeBanner: false,
  //   ));
  // }
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
        debugShowCheckedModeBanner: true,

        // theme: _buildShrineTheme(),

      ),
    );

  }
}
// ThemeData _buildShrineTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     colorScheme: _shrineColorScheme,
//     accentColor: shrineBrown900,
//     primaryColor: shrinePink100,
//     buttonColor: shrinePink100,
//     scaffoldBackgroundColor: shrineBackgroundWhite,
//     cardColor: shrineBackgroundWhite,
//     textSelectionColor: shrinePink100,
//     errorColor: shrineErrorRed,
//     buttonTheme: const ButtonThemeData(
//       colorScheme: _shrineColorScheme,
//       textTheme: ButtonTextTheme.normal,
//     ),
//     primaryIconTheme: _customIconTheme(base.iconTheme),
//     textTheme: _buildShrineTextTheme(base.textTheme),
//     primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//     iconTheme: _customIconTheme(base.iconTheme),
//   );
// }
// IconThemeData _customIconTheme(IconThemeData original) {
//   return original.copyWith(color: shrineBrown900);
// }
//
// TextTheme _buildShrineTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//     caption: base.caption?.copyWith(
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: defaultLetterSpacing,
//     ),
//     button: base.button?.copyWith(
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: defaultLetterSpacing,
//     ),
//   )
//       .apply(
//     fontFamily: 'Rubik',
//     displayColor: shrineBrown900,
//     bodyColor: shrineBrown900,
//   );
// }
//
// const ColorScheme _shrineColorScheme = ColorScheme(
//   primary: shrinePink100,
//   primaryVariant: shrineBrown900,
//   secondary: shrinePink50,
//   secondaryVariant: shrineBrown900,
//   surface: shrineSurfaceWhite,
//   background: shrineBackgroundWhite,
//   error: shrineErrorRed,
//   onPrimary: shrineBrown900,
//   onSecondary: shrineBrown900,
//   onSurface: shrineBrown900,
//   onBackground: shrineBrown900,
//   onError: shrineSurfaceWhite,
//   brightness: Brightness.light,
// );
//
// const Color shrinePink50 = Color(0xFFFEEAE6);
// const Color shrinePink100 = Color(0xFFFEDBD0);
// const Color shrinePink300 = Color(0xFFFBB8AC);
// const Color shrinePink400 = Color(0xFFEAA4A4);
//
// const Color shrineBrown900 = Color(0xFF442B2D);
// const Color shrineBrown600 = Color(0xFF7D4F52);
//
// const Color shrineErrorRed = Color(0xFFC5032B);
//
// const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
// const Color shrineBackgroundWhite = Colors.white;
//
// const defaultLetterSpacing = 0.03;


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



