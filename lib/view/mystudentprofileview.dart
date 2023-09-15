import 'package:flutter/material.dart';
import '../model/student.dart'; // Import your Student model
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MyStudentProfileView extends StatefulWidget {
  const MyStudentProfileView({Key? key}) : super(key: key);

  @override
  MyStudentProfileViewState createState() => MyStudentProfileViewState();
}

class MyStudentProfileViewState extends State<MyStudentProfileView> {
  List<Student> students = [];
  Student? currentStudent;
  TextEditingController _studentIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/students.json');
      final jsonData = json.decode(jsonString);
      final List<Student> loadedStudents = [];

      for (var item in jsonData) {
        loadedStudents.add(Student.fromJson(item));
      }

      setState(() {
        students = loadedStudents;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _loadStudentById(String studentId) {
    final student = students.firstWhere(
      (element) => element.studentID == studentId,
      orElse: () => Student(
        firstName: '',
        lastName: '',
        studentID: '',
        institutionName: '',
        email: '',
        password: '',
        profilePhoto: '',
      ),
    );

    setState(() {
      currentStudent = student;
    });
  }

  void _updateStudentInfo() {
    if (currentStudent != null) {
      setState(() {
        final index = students.indexWhere(
          (student) => student.studentID == currentStudent!.studentID,
        );
        if (index != -1) {
          students[index] = currentStudent!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Profil Etudiant')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    child: TextField(
                      controller: _studentIDController,
                      decoration: const InputDecoration(
                        labelText: 'Entrer ID etudiant',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _loadStudentById(_studentIDController.text);
                  },
                  child: const Text('Charger'),
                ),
              ],
            ),
          ),
          if (currentStudent != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentStudent!.profilePhoto.isNotEmpty)
                    Image.asset(
                      'assets/images/${currentStudent!.profilePhoto}',
                      width: 200,
                      height: 200,
                    ),
                  const SizedBox(height: 12),
                  _buildTextField("Nom", currentStudent!.firstName),
                  _buildTextField("Prénom", currentStudent!.lastName),
                  _buildTextField("Numéro de dossier", currentStudent!.studentID),
                  _buildTextField("Nom de l'institution", currentStudent!.institutionName),
                  _buildTextField("Adresse e-mail", currentStudent!.email),
                  _buildTextField("Mot de passe", currentStudent!.password),
                  ElevatedButton(
                    onPressed: () {
                      _updateStudentInfo();
                    },
                    child: const Text('Mise a jour'),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}


Widget _buildTextField(String labelText, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      width: 392,
      child: TextField(
        controller: TextEditingController(text: value),
        onChanged: (newValue) {
          if (currentStudent != null) {
            setState(() {
              switch (labelText) {
                case "Nom":
                  currentStudent!.firstName = newValue;
                  break;
                case "Prénom":
                  currentStudent!.lastName = newValue;
                  break;
                case "Numéro de dossier":
                  currentStudent!.studentID = newValue;
                  break;
                case "Nom de l'institution":
                  currentStudent!.institutionName = newValue;
                  break;
                case "Adresse e-mail":
                  currentStudent!.email = newValue;
                  break;
                case "Mot de passe":
                  currentStudent!.password = newValue;
                  break;
              }
            });
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    ),
  );
}


  @override
  void dispose() {
    _studentIDController.dispose();
    super.dispose();
  }
}
