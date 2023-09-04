
import 'package:flutter/material.dart';
import 'package:flutter_project_template_a/config/myconfig.dart';
import 'package:flutter_project_template_a/view/mystudentprofileview.dart';
import 'package:provider/provider.dart';
import '../model/courses_list.dart';
import 'mycoursedetailsview.dart';
import 'myhomepage.dart';

class MyCoursesView extends StatelessWidget {
  const MyCoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coursesList.length,
      itemBuilder: (context, index) {
        return Hero(
          tag: "ListTile-Hero-${coursesList[index].code}",
          child: Material(
            child: ListTile(
              title: Text(coursesList[index].title),
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Image.asset(
                  coursesList[index].imagePath,
                  width: 76,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                // MyConfig.myTabsObjList[1].content = MyCourseDetailsView(course: coursesList[index]);  
                // MyConfig.tabController.animateTo(1);   
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyCourseDetailsView(course: coursesList[index]);
                    },
                  ),
                );              
              },
            ),
          ),
        );
      },
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:flutter_project_template_a/config/myconfig.dart';
// import '../model/courses_list.dart';
// import 'mycoursedetailsview.dart';


// class MyCoursesView extends StatelessWidget {

//   const MyCoursesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: coursesList.length,
//       itemBuilder: (context, index) {
//         return Hero(
//           tag: "ListTile-Hero-${coursesList[index].code}",
//           child: Material(
//             child: ListTile(
//               title: Text(coursesList[index].title),
//               contentPadding: const EdgeInsets.all(10),
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                 child: Image.asset(
//                   coursesList[index].imagePath,
//                   width: 76,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               onTap: () {
//                 // Au lieu de Navigator.push, utilisez MyConfig.tabController pour changer d'onglet
//                 MyConfig.myTabsObjList[1].content = MyCourseDetailsView(course: coursesList[index]);
//                 MyConfig.tabController.animateTo(1); // Assurez-vous que 1 est l'index de l'onglet des détails
//                 // MyConfig.selectedCourseDetails = coursesList[index];
//                 // MyCourseDetailsView(course: coursesList[index]); // Stockez les détails du cours sélectionné
//               },  
//             ),
//           ),
//         );
//       },
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import '../model/courses_list.dart';
// import 'mycoursedetailsview.dart';

// class MyCoursesView extends StatelessWidget {

//   const MyCoursesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: coursesList.length,
//       itemBuilder: (context, index) {
//         return Hero(
//           tag: "ListTile-Hero-${coursesList[index].code}",
//           child: Material(
//             child: ListTile(
//               title: Text(coursesList[index].title),
//               contentPadding: const EdgeInsets.all(10),
//               // tileColor: Colors.cyan,
//               // tileColor: Colors.blue[700],
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                 child: Image.asset(
//                   coursesList[index].imagePath,
//                   width: 76,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (BuildContext context) {
//                       return MyCourseDetailsView(course: coursesList[index]);
//                     },
//                   ),
//                 );
//               },  
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// Le main est présent seulement pour test que tout fonctionne indépendamment 
// void main() => runApp(const MyCoursesView(title: "Test MyCoursesView"));


// class MyCoursesView extends StatelessWidget {
//   final String title;
//   const MyCoursesView({required this.title, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         listTileTheme: const ListTileThemeData(
//           textColor: Colors.white,
//         ),
//         useMaterial3: true,
//       ),
//       home: const ListTileCourse(),
//     );
//   }
// }

// class ListTileCourse extends StatefulWidget {
//   const ListTileCourse({super.key});

//   @override
//   State<ListTileCourse> createState() => _ListTileCourseState();
// }

// class _ListTileCourseState extends State<ListTileCourse>
//     with TickerProviderStateMixin {
//   late final AnimationController _fadeController;
//   late final AnimationController _sizeController;
//   late final Animation<double> _fadeAnimation;
//   late final Animation<double> _sizeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);

//     _sizeController = AnimationController(
//       duration: const Duration(milliseconds: 850),
//       vsync: this,
//     )..repeat(reverse: true);

//     _fadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     );

//     _sizeAnimation = CurvedAnimation(
//       parent: _sizeController,
//       curve: Curves.easeOut,
//     );
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _sizeController.dispose();
//     super.dispose();
//   }

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Liste des cours')),
//       body: ListView.builder(
//         itemCount: coursesList.length,
//         itemBuilder: (context, index) {
//           return Hero(
//             tag: "ListTile-Hero-${coursesList[index].code}",
//             child: Material(
//               child: ListTile(
//                 title: Text(coursesList[index].title),
//                 contentPadding: const EdgeInsets.all(10),
//                 // tileColor: Colors.cyan,
//                 tileColor: Colors.blue[700],
//                 leading: 
                
//                 ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                       child:Image.asset(
//                   coursesList[index].imagePath,
//                   width: 76,
//                   fit: BoxFit.cover,
//                 ),),
                
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) {
//                         return MyCourseDetailsView(course: coursesList[index]);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

// }

// Exemple de FadeTransition ListTile Widget **CONSERVER**
// FadeTransition(
//   opacity: _fadeAnimation,
//   // Wrap the ListTile in a Material widget so the ListTile has someplace
//   // to draw the animated colors during the fade transition.
//   child: const Material(
//     child: ListTile(
//       title: Text('ListTile with FadeTransition'),
//       selectedTileColor: Colors.green,
//       selectedColor: Colors.white,
//       selected: true,
//     ),
//   ),
// )

// Exemple de SizeTransition ListTile Widget **CONSERVER**
// SizedBox(
//   height: 100,
//   child: Center(
//     child: SizeTransition(
//       sizeFactor: _sizeAnimation,
//       axisAlignment: -1.0,
//       // Wrap the ListTile in a Material widget so the ListTile has someplace
//       // to draw the animated colors during the size transition.
//       child: const Material(
//         child: ListTile(
//           title: Text('ListTile with SizeTransition'),
//           tileColor: Colors.red,
//           minVerticalPadding: 25.0,
//         ),
//       ),
//     ),
//   ),
// ),


