// Le package sert de référence globale pour le projet

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'mytheme.dart';
import '../view/mysplashscreen.dart';
import '../view/myhomepage.dart';
import '../view-extra/mycoursesview.dart';
import '../view/mycoursesviewstore.dart';
import '../view-extra/mycoursedetailspage.dart';
import '../view/mycoursedetailsview.dart';
import '../view/mystudentprofileview.dart';
import '../model/course.dart';
import '../view/login.dart';
import '../model/student.dart';

enum ClassNames {
  MySplashScreen,
  MyHomePage,
  MyCoursesView,
  MyCoursesViewStore,
  MyCourseDetailsView,
  MyCourseDetailsPage,
  MyStudentProfileView,
  MyAppBar,
  MyDrawer,
  MyTabBar,
  MyTabBarView,
}

// MyConfig
class MyConfig {
  static bool assetFromFirebase = false;
  static Course currentCourse =
      Course(title: "", description: "", imagePath: "", code: "");
  static late TabController tabController;
  static List<Student> students = [];
  static late Student currentStudentLogged;

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
    {"icon": "home", "text": "Cours", "contentText": "Bienvenue. Choisisser un cours", "content": "MyCoursesViewStore",  "tabBarTitle": "Cours en ligne", "appBarTitle": "Cours en ligne", "drawerTitle": "Cours en ligne"}, 
    {"icon": "description_outlined", "text": "Détail", "contentText": "Détails du dernier cours choisi", "content": "MyCourseDetailsView", "tabBarTitle": "Legend2", "appBarTitle": "Home2", "drawerTitle": "Menu2"}, 
    {"icon": "account_circle_outlined", "text": "Profil", "contentText": "Profil étudiant", "content": "MyStudentProfileView", "tabBarTitle": "Legend3", "appBarTitle": "Home3", "drawerTitle": "Menu3"}   
  ]
  ''';

  static List<MyTab> myTabsObjList = MyTab.parseTabs(myTabsJsonStr, iconMap);

  static const String mainAppTitle = "Cours en ligne";

  // Définissez ici la liste des pages à afficher dans l'ordre souhaité
  static final List<Widget> pages = [
    MySplashScreen(),
    LoginPage(),
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

  static ClassNames? stringToClassNames(String value) {
    try {
      return ClassNames.values
          .firstWhere((e) => e.toString() == 'ClassNames.$value');
    } catch (e) {
      return null;
    }
  }

  static Widget createWidget(ClassNames widgetType) {
    switch (widgetType) {
      case ClassNames.MyCoursesView:
        return MyCoursesView();
      case ClassNames.MyCoursesViewStore:
        return MyCoursesViewStore();
      case ClassNames.MyCourseDetailsPage:
        return MyCourseDetailsPage(course: Course.getEmptyCourse());
      case ClassNames.MyCourseDetailsView:
        return MyCourseDetailsView();
      case ClassNames.MyStudentProfileView:
        return MyStudentProfileView();
      case ClassNames.MyAppBar:
        return MyAppBar(
            tabController: MyConfig.tabController,
            tabs: MyConfig.myTabsObjList);
      case ClassNames.MyDrawer:
        return MyDrawer(
            tabController: MyConfig.tabController,
            tabs: MyConfig.myTabsObjList);
      case ClassNames.MyTabBar:
        return MyTabBar(
            tabController: MyConfig.tabController,
            tabs: MyConfig.myTabsObjList);
      case ClassNames.MyTabBarView:
        return TabBarView(
          controller: MyConfig.tabController,
          children: MyConfig.myTabsObjList.map((tab) => tab.content).toList(),
        );
      default:
        throw Exception('Type de Widget inconnu: $widgetType');
    }
  }

  static int getTabIndexForTabController(ClassNames destinationView) {
    switch (destinationView) {
      case ClassNames.MyCoursesView:
        return 0;
      case ClassNames.MyCoursesViewStore:
        return 0;
      case ClassNames.MyCourseDetailsPage:
        return -1;
      case ClassNames.MyCourseDetailsView:
        return 1;
      case ClassNames.MyStudentProfileView:
        return 2;
      default:
        throw Exception('Tab index inconnu pour: $destinationView');
    }
  }

  static String getUrlForFirebase(String imageNameAndPath) {
    String copy = imageNameAndPath;
    String replaced;
    if (copy == "") {
      copy = "images_store/png_transparent.png";
    }
    replaced = copy.replaceAll('/', '%2F');
    return 'https://firebasestorage.googleapis.com/v0/b/cours-en-ligne-9a9e7.appspot.com/o/$replaced?alt=media&token=455da142-c24e-409e-9bd2-fc5cb005650a';
  }

  static Image getImage(String imageNameAndPath, double width) {
    String copy = imageNameAndPath;

    if (assetFromFirebase) {
      copy = getUrlForFirebase(imageNameAndPath);
    }

    print('getImage: $copy');

    if (copy.contains("http")) {
      return Image.network(copy, width: width, fit: BoxFit.cover);
    } else if (copy == "") {
      return Image.asset("assets/images/png_transparent.png",
          width: width, fit: BoxFit.cover);
    } else {
      return Image.asset(copy, width: width, fit: BoxFit.cover);
    }
  }

  static Future<List<Course>> loadCourses() async {
    String coursesJsonFilePath = 'assets/data/courses.json';
    String jsonString = await rootBundle.loadString(coursesJsonFilePath);
    List<dynamic> jsonList = json.decode(jsonString);
    List<Course> courses =
        jsonList.map((data) => Course.fromJson(data)).toList();
    return courses;
  }

  static Future<void> loadStudentsFromStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('students').get();

    List<Student> students = querySnapshot.docs.map((document) {
      return Student.fromJson(document.data());
    }).toList();

    MyConfig.students = students;
    for (var item in MyConfig.students) {
      print('loadStudentsFromStore:\n$item');
    }
  }

  static Future<void> saveStudentsToStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference studentsCollection = firestore.collection('students');

    // Créez une instance de WriteBatch pour regrouper toutes les opérations
    WriteBatch batch = firestore.batch();

    for (Student student in MyConfig.students) {
      DocumentReference docRef = studentsCollection.doc(student.studentID);

      batch.set(
          docRef,
          student
              .toJson()); // utilisez `update` au lieu de `set` si vous voulez uniquement mettre à jour les documents existants
    }

    // Exécutez toutes les opérations en une seule fois
    await batch.commit();
  }

  // Sert si on utilise un fichier json local plutôt que firebase
  static Future<List<Student>> loadStudents() async {
    String studentsJsonFilePath = 'assets/data/students.json';
    String jsonString = await rootBundle.loadString(studentsJsonFilePath);
    List<dynamic> jsonList = json.decode(jsonString);
    List<Student> students =
        jsonList.map((data) => Student.fromJson(data)).toList();
    MyConfig.students = students;
    return students;
  }

  // Ne fonctionne pas car sous Chrome l'accès local est restreint, on doit faire autrement via indexDB, etc
  static Future<void> saveStudents() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/students.json');
    List<Map<String, dynamic>> jsonList =
        MyConfig.students.map((student) => student.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
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
              content: MyConfig.createWidget(
                  MyConfig.stringToClassNames(json['content'])!),
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<MyTab> tabs;

  const MyAppBar({required this.tabController, required this.tabs, super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(tabs[tabController.index].appBarTitle ??
          'Not configured yet!'), // Le titre est tjr defini par le premier objet MyTab du tableau tabs[] pour l'instant
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

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  final List<MyTab> tabs;

  const MyTabBar({required this.tabController, required this.tabs, super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      labelStyle: Theme.of(context).textTheme.labelMedium,
      unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
      tabs: tabs.map((tab) {
        return Tab(icon: tab.icon, text: tab.text);
      }).toList(),
    );
  }
}
