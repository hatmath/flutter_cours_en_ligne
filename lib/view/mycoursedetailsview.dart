import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import 'videoplayerscreen.dart';

class MyCourseDetailsView extends StatefulWidget {
  @override
  _MyCourseDetailsViewState createState() => _MyCourseDetailsViewState();
}

class _MyCourseDetailsViewState extends State<MyCourseDetailsView> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2), // Durée de l'effet fade
      vsync: this,
    )..forward(); // Démarrer l'animation dès le début
  }

  @override
  void dispose() {
    _fadeController.dispose(); // Toujours disposer les controllers quand ils ne sont plus utilisés
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Liste initiale des enfants
    List<Widget> children = [
      SizedBox(height: 20.0),
      MyConfig.getImage(MyConfig.currentCourse.imagePath, 250),
      SizedBox(height: 10.0),
      Text(MyConfig.currentCourse.code),
      SizedBox(height: 10.0),
      Text(MyConfig.currentCourse.title),
      SizedBox(height: 10.0),
      Text(MyConfig.currentCourse.description),
      SizedBox(height: 20.0),
    ];

    // Si MyConfig.currentCourse.code n'est pas vide, ajouter le bouton à la liste
    if (MyConfig.currentCourse.code.isNotEmpty) {
      children.add(
        FadeTransition(
          opacity: _fadeController,
          child: ElevatedButton(
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
                  horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      );
    }

    return Center(
      child: Hero(
        tag: "course-${MyConfig.currentCourse.code}",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}


