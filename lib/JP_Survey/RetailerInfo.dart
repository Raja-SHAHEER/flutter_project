import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ByBps.dart';
import 'ByCity.dart';


class RetailerInfo extends StatefulWidget {
  // RetailerInfo(this.colorVal);
  // int colorVal;
  @override
  State<RetailerInfo> createState() => _RetailerInfo();
}

class _RetailerInfo extends State<RetailerInfo> with SingleTickerProviderStateMixin {
  late TabController _TabController;

  @override
  void initState() {
    super.initState();
    _TabController = new TabController(vsync: this, length: 2);
    // _TabController.addListener(_handleTabSelection);
  }

  // void _handleTabSelection() {
  //   setState(() {
  //     //set the tab selected colors
  //     //widget.colorVal=0xffff5722;
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _TabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 12,
            bottom: TabBar(
              // padding: EdgeInsets.all(5),
              controller: _TabController,
              isScrollable: true,
              indicatorWeight: 2.0,
             //unselectedLabelColor: Colors.grey,
              tabs:<Widget> [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5.0,),
                    child: Tab(text: "By City",)),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5.0,),
                    child: Tab(text: "By Bp's",)),
              ],
            ),
          ),
          body: TabBarView(
            controller: _TabController,
            children: <Widget>[
              ByCity(),
              ByBps(),
            ],

          ),
        ),
      ),
    );
  }
}



