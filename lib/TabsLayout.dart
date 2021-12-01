import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Observation.dart';
import 'RetailerInfo.dart';

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
