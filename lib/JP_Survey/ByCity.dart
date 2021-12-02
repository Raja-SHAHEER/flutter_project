import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../main.dart';

class ByCity extends StatefulWidget {
  @override
  State<ByCity> createState() => _ByCity();
}

class _ByCity extends State<ByCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 8,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: RichText(
              text: TextSpan(
                text: 'Please Choose Your City',
                  style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                ]
              )

            ),

        ),


      ),
      ),
    );
  }
}
