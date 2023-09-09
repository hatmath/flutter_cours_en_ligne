import 'package:flutter/material.dart';
import '../theme/mytheme.dart';
import '../config/myconfig.dart';

class MyDrawer extends StatelessWidget {
  final TabController tabController;
  final List<MyTab> tabs;

  const MyDrawer({required this.tabController, required this.tabs, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyTheme.currentThemeData.drawerTheme.shadowColor,
            ),
            child: Text(
              tabs[tabController.index].drawerTitle ?? 'Not configured yet!',
              style: TextStyle(
                color: MyTheme.currentThemeData.primaryColorLight,
                fontSize: 24,
              ),
            ),
          ),
          for (int index = 0; index < tabs.length; index++)
            ListTile(
              title: Text(tabs[index].text),
              onTap: () {
                Navigator.pop(context);
                tabController.animateTo(index);
              },
            ),
        ],
      ),
    );
  }
}


