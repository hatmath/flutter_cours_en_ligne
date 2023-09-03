import 'package:flutter/material.dart';
import 'dart:convert';

// MyConfig
class MyConfig {
  
  // Créez un mappage des noms d'icônes aux objets IconData pour votre application 
  // car il n'est pas possible de créer un Icon ou un IconData avec un String directement
  static final Map<String, IconData> iconMap = {
    'home': Icons.home,
    'description_outlined': Icons.description_outlined,
    'account_circle_outlined': Icons.account_circle_outlined,
    // Ajoutez d'autres icônes au besoin
  };

   // Créez un json string des tab que vous désirez pour votre application
   // Mettre le Flutter ID tel que défini sur https://fonts.google.com/icons comme valeur pour la clé icon
  static const String myTabsJsonStr = '''
  [
    {"icon": "home", "text": "Tab 1", "contentText": "Tab 1 contenu", "tabBarTitle": "Legend1", "appBarTitle": "Home1", "drawerTitle": "Menu1"}, 
    {"icon": "description_outlined", "text": "Tab 2", "contentText": "Tab 2 contenu", "tabBarTitle": "Legend2", "appBarTitle": "Home2", "drawerTitle": "Menu2"}, 
    {"icon": "account_circle_outlined", "text": "Tab 3", "contentText": "Tab 3 contenu","tabBarTitle": "Legend3", "appBarTitle": "Home3", "drawerTitle": "Menu3"}   
  ]
  ''';
    
  static final List<MyTab> myTabsObjList = MyTab.parseTabs(myTabsJsonStr,iconMap);

}

// MyTab 
class MyTab {
  final Icon icon;
  final String text;
  final String contentText;
  final String? tabBarTitle;
  final String? appBarTitle;
  final String? drawerTitle;

  MyTab({required this.icon, required this.text, required this.contentText, this.tabBarTitle, this.appBarTitle, this.drawerTitle});

  static List<MyTab> parseTabs(String jsonStr, Map<String, IconData> iconMap) {
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    return parsed
        .map<MyTab>((json) => MyTab(
              icon: MyIcon.createIconFromClassName(json['icon'],iconMap),
              text: json['text'],
              contentText: json['contentText'],
              tabBarTitle: json['tabBarTitle'],
              appBarTitle: json['appBarTitle'],
              drawerTitle: json['drawerTitle'],
            ))
        .toList();
  }

}

// MyIcon 
class MyIcon {

  static Icon createIconFromClassName(String iconName, Map<String, IconData> iconMap ) {
    // Obtenez l'icône correspondante à partir du mappage
    final IconData? iconData = iconMap[iconName];

    if (iconData != null) {
      return Icon(iconData);
    } else {
      // Gérez le cas où l'icône n'est pas trouvée
      return const Icon(Icons.error);
    }
  }

}
