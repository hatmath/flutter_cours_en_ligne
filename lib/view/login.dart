import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_cours_en_ligne_v2/view/myhomepage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool acceptedCondition = false;
  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsersData();
  }

  Future<void> _loadUsersData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/connection.json');
      final dynamic jsonData = json.decode(jsonString);

      if (jsonData is Map<String, dynamic> &&
          jsonData.containsKey('users') &&
          jsonData['users'] is List<dynamic>) {
        final List<dynamic> usersData = jsonData['users'];
        setState(() {
          users = usersData
              .map((dynamic user) {
                if (user is Map<String, dynamic> &&
                    user.containsKey('username') &&
                    user.containsKey('password') &&
                    user['username'] is String &&
                    user['password'] is String) {
                  return <String, String>{
                    'username': user['username'] as String,
                    'password': user['password'] as String,
                  };
                }
                return null;
              })
              .whereType<Map<String, String>>()
              .toList();
        });
      }
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  void _addUser() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        users.add({
          'username': username,
          'password': password,
        });
      });

      _usernameController.clear();
      _passwordController.clear();

      // Save the updated user data to the JSON file.
      _saveUserListToJson(users);
    }
  }

  Future<void> _saveUserListToJson(List<Map<String, String>> userList) async {
    final Map<String, dynamic> jsonData = {'users': userList};
    final jsonString = json.encode(jsonData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/connection.json');

    try {
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving JSON: $e');
    }
  }

  Future<bool> authenticateUser(String username, String password) async {
    for (final Map<String, String> user in users) {
      if (user['username'] == username && user['password'] == password) {
        return true;
      }
    }
    return false;
  }

  Future<void> _loginWithCredentials(String username, String password) async {
    final isAuthenticated = await authenticateUser(username, password);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: false,
            ),
            SizedBox(height: 20),
            Row(
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
                Text('J\'accepte les conditions d\'utilisation.'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: acceptedCondition
                  ? () {
                      _loginWithCredentials(
                        _usernameController.text,
                        _passwordController.text,
                      );
                    }
                  : null,
              child: Text('Log In'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Ajouter un utilisateur'),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
    );
  }
}
