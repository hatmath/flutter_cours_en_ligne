import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import '../model/course.dart';
// import 'mycoursedetailspage.dart';

class MyCoursesView extends StatelessWidget {
  const MyCoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: MyConfig.loadCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text("Erreur lors du chargement"));
          }
          List<Course> courses = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(20.0),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: "course-${courses[index].code}",
                child: Material(
                  child: ListTile(
                    title: Text(courses[index].title,
                        style: Theme.of(context).textTheme.labelMedium),
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: MyConfig.getImage(courses[index].imagePath, 76),
                    ),
                    onTap: () {
                      MyConfig.currentCourse = courses[index];
                      MyConfig.tabController.animateTo(
                          MyConfig.getTabIndexForTabController(
                              ClassNames.MyCourseDetailsView));
                      // ? ... ou on ouvre une page MyCourseDetailsPage pour avoir l'effet Hero mais ça bogue après
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return MyCourseDetailsPage(course: coursesList[index]);
                      //     },
                      //   ),
                      // );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
