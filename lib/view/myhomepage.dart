
import 'package:flutter/material.dart';
import '../config/myconfig.dart';
// import '../widget/myappbar.dart';
// import '../widget/mydrawer.dart';
// import '../widget/mytabbar.dart';

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
      appBar: MyConfig.createWidget(ClassNames.MyAppBar) as PreferredSizeWidget,
      body: MyConfig.createWidget(ClassNames.MyTabBarView),
      bottomNavigationBar: MyConfig.createWidget(ClassNames.MyTabBar),
      drawer:  MyConfig.createWidget(ClassNames.MyDrawer),
    );
  } 
}
