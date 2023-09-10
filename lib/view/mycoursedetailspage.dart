import 'package:flutter/material.dart';
import '../model/course.dart';

class MyCourseDetailsPage extends StatelessWidget {
  final Course course;

  const MyCourseDetailsPage({required this.course, super.key});

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