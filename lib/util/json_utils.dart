// json_utils.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/student.dart';


class JsonUtils {
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/student.json');
  }

  static Future<void> saveStudent(Student student) async {
    final file = await _getLocalFile();
    final studentMap = student.toJson();
    final studentJson = jsonEncode(studentMap);
    await file.writeAsString(studentJson);
  }

  static Future<Student?> loadStudent() async {
    try {
      final file = await _getLocalFile();
      final jsonString = await file.readAsString();
      final studentMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return Student(
        firstName: studentMap['firstName'],
        lastName: studentMap['lastName'],
        studentID: studentMap['studentID'],
        institutionName: studentMap['institutionName'],
        email: studentMap['email'],
        password: studentMap['password'],
        profilePhoto: studentMap['profilePhoto'],
      );
    } catch (e) {
      return null;
    }
  }
}


void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  Student student1 = Student(
    firstName: 'John2',
    lastName: 'Doe',
    studentID: '123456',
    institutionName: 'ABC University',
    email: 'john.doe@example.com',
    password: 'password123',
    profilePhoto: 'profile_image.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON File Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => JsonUtils.loadStudent(),
              child: const Text('Read JSON File'),
            ),
            ElevatedButton(
              onPressed: () => JsonUtils.saveStudent(student1),
              child: const Text('Write JSON File'),
            ),
          ],
        ),
      ),
    );
  }
}


