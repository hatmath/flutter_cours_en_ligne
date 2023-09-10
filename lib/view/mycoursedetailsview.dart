import 'package:flutter/material.dart';
import '../config/myconfig.dart';

import 'videoplayerscreen.dart';

class MyCourseDetailsView extends StatelessWidget {
  const MyCourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "course-${MyConfig.currentCourse.code}",
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), 
          child: SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                MyConfig.getImage(MyConfig.currentCourse.imagePath, 250),
                SizedBox(height: 10.0),
                Text(MyConfig.currentCourse.code),
                SizedBox(height: 10.0),
                Text(MyConfig.currentCourse.title),
                SizedBox(height: 10.0),
                Text(MyConfig.currentCourse.description),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                            videoPath: 'assets/videos/video.mp4'),
                      ),
                    );
                  },
                  child: Text("Démarrer"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // espace interne du bouton
                    shape: RoundedRectangleBorder(
                      // forme du bouton
                      borderRadius:
                          BorderRadius.circular(8), // rayon du coin arrondi
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../config/myconfig.dart';

// import 'videoplayerscreen.dart';

// class MyCourseDetailsView extends StatelessWidget {
//   const MyCourseDetailsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Hero(
//         tag: "course-${MyConfig.currentCourse.code}",
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 20.0), // Ajoute un espace horizontal sur les côtés
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 20.0),
//               MyConfig.getImage(MyConfig.currentCourse.imagePath, 250),
//               SizedBox(height: 10.0),
//               Text(MyConfig.currentCourse.code),
//               SizedBox(height: 10.0),
//               Text(MyConfig.currentCourse.title),
//               SizedBox(height: 10.0),
//               Text(MyConfig.currentCourse.description),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => VideoPlayerScreen(
//                           videoPath: 'assets/videos/video.mp4'),
//                     ),
//                   );
//                 },
//                 child: Text("Démarrer"),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 20, vertical: 12), // espace interne du bouton
//                   shape: RoundedRectangleBorder(
//                     // forme du bouton
//                     borderRadius:
//                         BorderRadius.circular(8), // rayon du coin arrondi
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
