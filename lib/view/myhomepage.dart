import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import '../widget/myappbar.dart';
import '../widget/mydrawer.dart';
import '../widget/mytabbar.dart';


class MyHomePage extends StatefulWidget {

  const MyHomePage ({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: MyConfig.myTabsObjList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
      body: TabBarView(
        controller: _tabController,
        children:MyConfig.myTabsObjList.map((tab) {
          return Center(
            child: Text(tab.contentText), // Utilisez le contentText de l'objet MyTab
          );
        }).toList(),
      ),
      bottomNavigationBar: MyTabBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
      drawer: MyDrawer(tabController: _tabController, tabs: MyConfig.myTabsObjList),
    );
  }
}