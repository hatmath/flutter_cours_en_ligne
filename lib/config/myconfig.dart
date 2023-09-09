import 'package:flutter/material.dart';
import 'dart:convert';

import '../view/mysplashscreen.dart';
import '../view/myhomepage.dart';
import '../view/mycoursesview.dart';
import '../view/mystudentprofileview.dart';
import '../model/course.dart';
import '../view/mycoursedetailsview.dart';
import '../view/mycoursedetailsviewtab.dart';

// MyConfig
class MyConfig {

  static Course currentCourse =   Course(title: "",description: "",imagePath: "assets/images/png-transparent-back.png",code: "");

  static late TabController tabController;
 
  // Créez un mappage des noms d'icônes
  static final Map<String, IconData> iconMap = {
    'home': Icons.home,
    'description_outlined': Icons.description_outlined,
    'account_circle_outlined': Icons.account_circle_outlined,
    // Ajoutez d'autres icônes au besoin
  };

  // Créez un json string des tab que vous désirez pour votre application
  // Pour la clé icon, mettre le Flutter ID tel que défini sur https://fonts.google.com/icons
  static const String myTabsJsonStr = '''
  [
    {"icon": "home", "text": "Cours", "contentText": "Bienvenue. Choisisser un cours", "content": "MyCoursesView",  "tabBarTitle": "Cours en ligne", "appBarTitle": "Cours en ligne", "drawerTitle": "Cours en ligne"}, 
    {"icon": "description_outlined", "text": "Détail", "contentText": "Détails du dernier cours choisi", "content": "MyCourseDetailsViewTab", "tabBarTitle": "Legend2", "appBarTitle": "Home2", "drawerTitle": "Menu2"}, 
    {"icon": "account_circle_outlined", "text": "Profil", "contentText": "Profil étudiant", "content": "MyStudentProfileView", "tabBarTitle": "Legend3", "appBarTitle": "Home3", "drawerTitle": "Menu3"}   
  ]
  ''';

  static List<MyTab> myTabsObjList =
      MyTab.parseTabs(myTabsJsonStr, iconMap);

  static const String mainAppTitle = "Cours en ligne";

  // Définissez ici la liste des pages à afficher dans l'ordre souhaité
  static final List<Widget> pages = [
    MySplashScreen(),
    MyHomePage(),
    // Ajoutez d'autres pages ici au besoin
  ];

  static int _currentPageIndex = 0;

  static Widget getNextPage() {
    // Vérifiez si l'index de la page suivante est valide
    if (_currentPageIndex + 1 < MyConfig.pages.length) {
      final Widget nextPage = MyConfig.pages[_currentPageIndex + 1];
      // Mettez à jour l'index de la page courante
      MyConfig._currentPageIndex = _currentPageIndex + 1;
      return nextPage;
    } else {
      // Gérez le cas où la page suivante n'est pas trouvée
      return Scaffold(
        body: Center(
          child: Text('Page suivante non trouvée.'),
        ),
      );
    }
  }

  static Widget createWidget(String widgetType) {
    switch (widgetType) {
      case 'MyCoursesView':
        return MyCoursesView();
      case 'MyCourseDetailsView':
        return MyCourseDetailsView(course: Course.getEmptyCourse());
      case 'MyCourseDetailsViewTab':
        return MyCourseDetailsViewTab();
      case 'MyStudentProfileView':
        return MyStudentProfileView();
      default:
        throw Exception('Unknown widget type: $widgetType');
    }
  }
}

// MyTab
class MyTab {
  final Icon icon;
  final String text;
  final String contentText;
  Widget content;
  final String? tabBarTitle;
  final String? appBarTitle;
  final String? drawerTitle;

  MyTab(
      {required this.icon,
      required this.text,
      required this.contentText,
      required this.content,
      this.tabBarTitle,
      this.appBarTitle,
      this.drawerTitle});

  static List<MyTab> parseTabs(String jsonStr, Map<String, IconData> iconMap) {
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    return parsed
        .map<MyTab>((json) => MyTab(
              icon: MyIcon.createIconFromClassName(json['icon'], iconMap),
              text: json['text'],
              contentText: json['contentText'],
              content: MyConfig.createWidget(json['content']),
              tabBarTitle: json['tabBarTitle'],
              appBarTitle: json['appBarTitle'],
              drawerTitle: json['drawerTitle'],
            ))
        .toList();
  }
}

// MyIcon
class MyIcon {
  static Icon createIconFromClassName(
      String iconName, Map<String, IconData> iconMap) {
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
