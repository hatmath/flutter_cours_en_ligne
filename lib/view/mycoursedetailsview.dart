

import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import '../model/course.dart'; // Import your course model

class MyCourseDetailsView extends StatelessWidget {
  final Course course;

  const MyCourseDetailsView({required this.course, super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cours')), // Ajoutez une app bar
      body:Center(
      child: Hero(
        tag: "course-${course.code}",
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Ajoute un espace horizontal sur les côtés
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Image.asset(
                course.imagePath,
                width: 250,
              ),
              SizedBox(height: 10.0),
              Text(course.code),
              SizedBox(height: 10.0),
              Text(course.title),
              SizedBox(height: 10.0),
              Text(course.description),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
    );
  }
}





// import 'package:flutter/material.dart';
// import '../model/course.dart'; // Import your course model

// class MyCourseDetailsView extends StatelessWidget {
//   final Course course;

//   const MyCourseDetailsView({required this.course,super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Cours')), 
//       body: Center(
//         child: Hero(
//           tag: "MyCourseDetailsView-${course.code}",
//           child: 
//           Column(children: [
//             Image.asset(course.imagePath, width: 250,),  
//             Text(course.code),              
//             Text(course.title),
//             Text(course.description),
//           ]
//         ),
//       ),
//     )
//     );
//   }
// }

// body: Center(
//         child: Hero(
//           tag: "ListTile-Hero-${course.code}",
//           child: Material(
//             child: ListTile(
//               title: Text(course.title),
//               subtitle: Text(course.description),
//               tileColor: Colors.blue[700],
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//       ),