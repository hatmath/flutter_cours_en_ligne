import 'package:flutter/material.dart';
import '../config/myconfig.dart';
import '../view/myhomepage.dart';
import '../model/student.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool acceptedCondition = false;

  @override
  void initState() {
    super.initState();
    MyConfig.loadStudentsFromStore();
  }

  Student createNewStudent(String studentID, String password) {
    return Student.fromJson({
      'studentID': studentID,
      'password': password,
      'firstName': '',
      'lastName': '',
      'institutionName': '',
      'email': '',
      'profilePhoto': '',
    });
  }

  Future<bool> authenticateUser(String studentID, String password) async {
    for (var student in MyConfig.students) {
      if (student.studentID == studentID && student.password == password) {
        MyConfig.currentStudentLogged = student;
        return true;
      }
    }
    return false;
  }

  void showUserCreatedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Utilisateur créé avec succès'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _loginWithCredentials(String studentID, String password) async {
    final isAuthenticated = await authenticateUser(studentID, password);

    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ));
    } else {
      print('Invalid');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Informations invalides'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connection')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Text('Étudiant: 12345'),
              Text('Mot de passe: test'),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _studentIDController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    labelText: 'Numéro étudiant',
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    labelText: 'Mot de passe',
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: true,
                        groupValue: acceptedCondition,
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              acceptedCondition = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Flexible(
                    child: Text('Accepter les conditions',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: acceptedCondition
                    ? () {
                        _loginWithCredentials(
                          _studentIDController.text,
                          _passwordController.text,
                        );
                      }
                    : null,
                child: Text('Se connecter'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final studentID = _studentIDController.text.trim();
                  final password = _passwordController.text.trim();

                  if (studentID.isNotEmpty && password.isNotEmpty) {
                    final newStudent = createNewStudent(studentID, password);
                    setState(() {
                      MyConfig.students.add(newStudent);
                      MyConfig.saveStudentsToStore();

                      _studentIDController.clear();
                      _passwordController.clear();
                    });
                    showUserCreatedSnackbar();
                  }
                },
                child: Text('Créer un utilisateur'),
              ),
            ],
          ),
        ),
      ),
      key: _scaffoldKey,
    );
  }
}
