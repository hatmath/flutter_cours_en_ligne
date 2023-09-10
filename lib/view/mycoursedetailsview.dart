import 'package:flutter/material.dart';
import '../model/course.dart';
import '../config/myconfig.dart';

class MyCourseDetailsView extends StatelessWidget {
  const MyCourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "course-${MyConfig.currentCourse.code}",
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Ajoute un espace horizontal sur les côtés
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),             
              Image.asset(
                MyConfig.currentCourse.imagePath,
                width: 250,
              ),
              SizedBox(height: 10.0),
              Text(MyConfig.currentCourse.code),
              SizedBox(height: 10.0),
              Text(MyConfig.currentCourse.title),
              SizedBox(height: 10.0),
              Text(MyConfig.currentCourse.description),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
