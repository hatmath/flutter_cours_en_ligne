import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import '../model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'mycoursedetailspage.dart';

class MyCoursesViewStore extends StatefulWidget {
  const MyCoursesViewStore({super.key});

  @override
  MyCoursesViewStoreState createState() => MyCoursesViewStoreState();
}

class MyCoursesViewStoreState extends State<MyCoursesViewStore> {
  @override
  Widget build(BuildContext context) {
    MyConfig.assetFromFirebase = false;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('courses').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final List<DocumentSnapshot> courses = snapshot.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.all(20.0),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Hero(
              tag: "course-${courses[index].get('code')}",
              child: Material(
                child: ListTile(
                  title: Text(courses[index].get('title'),
                      style: Theme.of(context).textTheme.labelLarge),
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    child:
                        MyConfig.getImage(courses[index].get('imagePath'), 76),
                  ),
                  onTap: () {
                    MyConfig.currentCourse = Course.fromMap(
                        courses[index].data() as Map<String, dynamic>);
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
      },
    );
  }
}
