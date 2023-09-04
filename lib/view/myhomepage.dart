
import 'package:flutter/material.dart';
import 'package:flutter_project_template_a/config/myconfig.dart';
import 'package:flutter_project_template_a/widget/myappbar.dart';
import 'package:flutter_project_template_a/widget/mydrawer.dart';
import 'package:flutter_project_template_a/widget/mytabbar.dart';
import '../model/courses_list.dart';
import 'mycoursedetailsview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: MyConfig.myTabsObjList.length, vsync: this);
    MyConfig.tabController = tabController;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(tabController: tabController, tabs: MyConfig.myTabsObjList),
      body: TabBarView(
        controller: tabController,
        children: MyConfig.myTabsObjList.map((tab) => tab.content).toList(),
      ),
      bottomNavigationBar: MyTabBar(tabController: tabController, tabs: MyConfig.myTabsObjList),
      drawer: MyDrawer(tabController: tabController, tabs: MyConfig.myTabsObjList),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../config/myconfig.dart';
// import '../widget/myappbar.dart';
// import '../widget/mydrawer.dart';
// import '../widget/mytabbar.dart';


// class MyHomePage extends StatefulWidget {

//   const MyHomePage ({super.key});

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   // static late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     MyConfig.initTabController(MyConfig.myTabsObjList.length, this);
//     //  _tabController = MyConfig.tabController;
//   }

//   // @override
//   // void dispose() {
//   //   _tabController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(tabController: MyConfig.tabController, tabs: MyConfig.myTabsObjList),
//       body: TabBarView(
//         controller: MyConfig.tabController,
//         children:MyConfig.myTabsObjList.map((tab) {
//           return tab.content;
//         }).toList(),
//       ),
//       bottomNavigationBar: MyTabBar(tabController: MyConfig.tabController, tabs: MyConfig.myTabsObjList),
//       drawer: MyDrawer(tabController: MyConfig.tabController, tabs: MyConfig.myTabsObjList),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../config/myconfig.dart';
// import '../widget/myappbar.dart';
// import '../widget/mydrawer.dart';
// import '../widget/mytabbar.dart';


// class MyHomePage extends StatefulWidget {

//   const MyHomePage ({super.key});

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   static late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     MyConfig.initTabController(MyConfig.myTabsObjList.length, this);
//      _tabController = MyConfig.tabController;
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       body: TabBarView(
//         controller: _tabController,
//         children:MyConfig.myTabsObjList.map((tab) {
//           return tab.content;
//         }).toList(),
//       ),
//       bottomNavigationBar: MyTabBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       drawer: MyDrawer(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_project_template_a/model/course.dart';
// import 'package:flutter_project_template_a/view/mycoursesview.dart';
// import '../config/myconfig.dart';
// import '../widget/myappbar.dart';
// import '../widget/mydrawer.dart';
// import '../widget/mytabbar.dart';
// import 'mycoursedetailsview.dart'; // Import your course details view


// class MyHomePage extends StatefulWidget {

//   const MyHomePage ({super.key});

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   late Widget _currentPage;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: MyConfig.myTabsObjList.length, vsync: this);
//     _currentPage = MyConfig.pages[0]; // Set initial page
//   }

//   void navigateToCourseDetails(Course course) {
//     setState(() {
//       _currentPage = MyCourseDetailsView(course: course);
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       body: TabBarView(
//         controller: _tabController,
//         children: MyConfig.pages.map((page) {
//           if (page is MyCoursesView) {
//             return page;
//           } else {
//             return Center(child: page);
//           }
//         }).toList(),
//       ),
//       bottomNavigationBar: MyTabBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       drawer: MyDrawer(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import '../config/myconfig.dart';
// import '../widget/myappbar.dart';
// import '../widget/mydrawer.dart';
// import '../widget/mytabbar.dart';
// import '../view/mycoursedetailsview.dart'; // Import your course details view

// class MyHomePage extends StatefulWidget {

//   const MyHomePage ({super.key});

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: MyConfig.myTabsObjList.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       body: Stack(
//         children: [
//           TabBarView(
//             controller: _tabController,
//             children: MyConfig.myTabsObjList.map((tab) {
//               return tab.content;
//             }).toList(),
//           ),
//           // Positioned pour afficher MyCourseDetailsView au centre avec effet Hero
//           Positioned.fill(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyCourseDetailsView(course: MyConfig.myTabsObjList[0])),
//                 );
//               },
//               child: Hero(
//                 tag: "MyCourseDetailsView-${MyConfig.myTabsObjList[0].text}", // Utilisation de text comme tag
//                 child: Container(),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: MyTabBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       drawer: MyDrawer(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import '../config/myconfig.dart';
// import '../widget/myappbar.dart';
// import '../widget/mydrawer.dart';
// import '../widget/mytabbar.dart';
// import '../view/mycoursedetailsview.dart'; // Import your course details view

// class MyHomePage extends StatefulWidget {

//   const MyHomePage ({super.key});

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: MyConfig.myTabsObjList.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       body: Stack(
//         children: [
//           TabBarView(
//             controller: _tabController,
//             children: MyConfig.myTabsObjList.map((tab) {
//               return Center(
//                 child: Text(tab.contentText), // Utilisez le contentText de l'objet MyTab
//               );
//             }).toList(),
//           ),
//           // Positioned pour afficher MyCourseDetailsView au centre avec effet Hero
//           Positioned.fill(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyCourseDetailsView(course: yourCourseObject)),
//                 );
//               },
//               child: Hero(
//                 tag: "MyCourseDetailsView-${yourCourseObject.code}",
//                 child: Container(),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: MyTabBar(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//       drawer: MyDrawer(tabController: _tabController, tabs: MyConfig.myTabsObjList),
//     );
//   }
// }
