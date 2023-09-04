import 'package:flutter/material.dart';
import '../util/json_utils.dart';
import '../model/student.dart';

class MyStudentProfileView extends StatefulWidget {
  const MyStudentProfileView({super.key});
  @override
  MyStudentProfileViewState createState() => MyStudentProfileViewState();
}

class MyStudentProfileViewState extends State<MyStudentProfileView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _studentIDController;
  late TextEditingController _institutionNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _profilePhotoController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _studentIDController = TextEditingController();
    _institutionNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _profilePhotoController = TextEditingController();

    _loadStudentProfile();
  }

  Future<void> _loadStudentProfile() async {
    final student = await JsonUtils.loadStudent();
    if (student != null) {
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _studentIDController.text = student.studentID;
      _institutionNameController.text = student.institutionName;
      _emailController.text = student.email;
      _passwordController.text = student.password;
      _profilePhotoController.text = student.profilePhoto;
    }
  }

  Future<void> _saveStudentProfile() async {
    final student = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      studentID: _studentIDController.text,
      institutionName: _institutionNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      profilePhoto: _profilePhotoController.text,
    );
    await JsonUtils.saveStudent(student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: "Nom"),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: "Prénom"),
              ),
              TextField(
                controller: _studentIDController,
                decoration: const InputDecoration(labelText: "Numéro de dossier"),
              ),
              TextField(
                controller: _institutionNameController,
                decoration: const InputDecoration(labelText: "Nom de l'institution"),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Adresse e-mail"),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Mot de passe"),
              ),
              TextField(
                controller: _profilePhotoController,
                decoration: const InputDecoration(labelText: "photo de profil"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveStudentProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _studentIDController.dispose();
    _institutionNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _profilePhotoController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyStudentProfileView(),
  ));
}
