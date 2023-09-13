import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firetone/profil.dart';
import 'package:flutter/material.dart';

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Widget _title() {
  return const Text('firebase auth sign');
}

Widget _userId() {
  User? currentUser = FirebaseAuth.instance.currentUser;
  return Text(currentUser?.email ?? 'user email', style: TextStyle(color: Colors.white));
}

Widget _signOutButton() {
  return IconButton(
    icon: Icon(Icons.logout, color: Colors.white),
    onPressed: signOut,
  );
}

class Cours {
  final String id;
  final String departement;
  final String nomDuCours;
  final int nombreDHeures;
  final String description;
  final String imagePath;

  Cours({
    required this.id,
    required this.departement,
    required this.nomDuCours,
    required this.nombreDHeures,
    required this.description,
    required this.imagePath,
  });
}

class HomePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Cours>> fetchCours() async {
    QuerySnapshot snapshot = await _firestore.collection('cours').get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Cours(
        id: doc.id,
        departement: data['departement'],
        nomDuCours: data['nomDuCours'],
        nombreDHeures: data['nombreDHeures'],
        description: data['description'],
        imagePath: data['imagePath'],
      );
    }).toList();
  }

  Future<String> _loadImage(String imagePath) async {
    return await _storage.ref(imagePath).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de Cours'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentProfileScreen()),
              );
            },
          ),
          _userId(),
          _signOutButton(),
        ],
      ),
      body: FutureBuilder<List<Cours>>(
        future: fetchCours(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No courses found.');
          } else {
            List<Cours> courses = snapshot.data!;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final cours = courses[index];
                return ListTile(
                  leading: FutureBuilder<String>(
                    future: _loadImage(cours.imagePath),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Image.network(snapshot.data!);
                        } else {
                          return Text('Error loading image.');
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  title: Text(cours.nomDuCours),
                  subtitle: Text('${cours.departement} - ${cours.nombreDHeures} heures'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(cours: cours),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Cours cours;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> _loadImage(String imagePath) async {
    return await _storage.ref(imagePath).getDownloadURL();
  }

  DetailsPage({required this.cours});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cours.nomDuCours)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: _loadImage(cours.imagePath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Hero(
                      tag: 'courseImage-${cours.nomDuCours}',
                      child: Image.network(snapshot.data!),
                    );
                  } else {
                    return Text('Error loading image.');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 16),
            Text('Département: ${cours.departement}'),
            Text('Nom du cours: ${cours.nomDuCours}'),
            Text('Nombre d\'heures: ${cours.nombreDHeures}'),
            Text('Description: ${cours.description}'),
          ],
        ),
      ),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}