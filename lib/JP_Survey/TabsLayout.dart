import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Observation.dart';
import 'RetailerInfo.dart';

class tablayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _tablayout();
}

class _tablayout extends State<tablayout>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,
          // backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 2,
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    var color = Color(0xff9c27b0);
                    break;
                  default:
                }
              });
            },
            tabs: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5.0,),
                  child: Tab(text: "RetailerInfo",)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5.0,),
                  child: Tab(text: "Observation",)),
            ],
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            RetailerInfo(),
            Observation(),
          ],
        ),
      ),
    );
  }
}
