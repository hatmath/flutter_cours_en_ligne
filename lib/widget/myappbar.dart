import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/myconfig.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  TabController tabController;
  List<MyTab> tabs;

  MyAppBar({required this.tabController, required this.tabs, super.key});

  @override
  Widget build(BuildContext context) {
    
   return AppBar(
      title: Text(tabs[tabController.index].appBarTitle ?? 'Not configured yet!'), // Le titre est tjr defini par le premier objet MyTab du tableau tabs[] pour l'instant
      actions: [
        for (int index = 0; index < tabs.length; index++)
          IconButton(
            icon: tabs[index].icon,
            onPressed: () {
              tabController.animateTo(index);
            },
          ),
      ],
    );
  }
}



