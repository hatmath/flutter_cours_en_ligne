import 'package:flutter/material.dart';
import '../model/student.dart';
import '../config/myconfig.dart';

class MyStudentProfileView extends StatefulWidget {
  const MyStudentProfileView({Key? key}) : super(key: key);

  @override
  MyStudentProfileViewState createState() => MyStudentProfileViewState();
}

class MyStudentProfileViewState extends State<MyStudentProfileView> {
  late Student currentStudent;
  TextEditingController _studentIDController = TextEditingController();
  String? updatedFirstName;
  String? updatedLastName;
  String? updatedStudentID;
  String? updatedInstitutionName;
  String? updatedEmail;
  String? updatedPassword;

  @override
  void initState() {
    super.initState();   
    currentStudent = MyConfig.currentStudentLogged; 
  }

  void _loadStudentById(String studentId) {
    final student = MyConfig.students.firstWhere(
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
        currentStudent!.firstName = updatedFirstName ?? currentStudent!.firstName;
        currentStudent!.lastName = updatedLastName ?? currentStudent!.lastName;
        currentStudent!.studentID = updatedStudentID ?? currentStudent!.studentID;
        currentStudent!.institutionName = updatedInstitutionName ?? currentStudent!.institutionName;
        currentStudent!.email = updatedEmail ?? currentStudent!.email;
        currentStudent!.password = updatedPassword ?? currentStudent!.password;
      });
      MyConfig.saveStudentsToStore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: const Text('Profil Etudiant')),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
          textDirection: TextDirection.ltr,
          onChanged: (newValue) {
            switch (labelText) {
              case "Nom":
                updatedFirstName = newValue;
                break;
              case "Prénom":
                updatedLastName = newValue;
                break;
              case "Numéro de dossier":
                updatedStudentID = newValue;
                break;
              case "Nom de l'institution":
                updatedInstitutionName = newValue;
                break;
              case "Adresse e-mail":
                updatedEmail = newValue;
                break;
              case "Mot de passe":
                updatedPassword = newValue;
                break;
            }
          },
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
