
import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import '../widget/myappbar.dart';
import '../widget/mydrawer.dart';
import '../widget/mytabbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    MyConfig.tabController = TabController(length: MyConfig.myTabsObjList.length, vsync: this);
  }

  @override
  void dispose() {
    MyConfig.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(tabController: MyConfig.tabController, tabs: MyConfig.myTabsObjList),
      body: TabBarView(
        controller: MyConfig.tabController,
        children: MyConfig.myTabsObjList.map((tab) => tab.content).toList(),
      ),
      bottomNavigationBar: MyTabBar(tabController: MyConfig.tabController, tabs: MyConfig.myTabsObjList),
      drawer: MyDrawer(tabController: MyConfig.tabController, tabs: MyConfig.myTabsObjList),
    );
  }
}
