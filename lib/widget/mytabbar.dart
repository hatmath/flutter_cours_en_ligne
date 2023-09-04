import 'package:flutter/material.dart';
import '../config/myconfig.dart'; // Importez le fichier config.dart pour les onglets

class MyTabBar extends StatelessWidget {
  TabController tabController;
  List<MyTab> tabs;

  MyTabBar({required this.tabController, required this.tabs, super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      tabs: tabs.map((tab) {
        return Tab(icon: tab.icon, text: tab.text);
      }).toList(),
    );
  }
}