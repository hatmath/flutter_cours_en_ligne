class Student {
  String firstName;
  String lastName;
  String studentID;
  String institutionName;
  String email;
  String password;
  String profilePhoto;

  Student({
    required this.firstName,
    required this.lastName,
    required this.studentID,
    required this.institutionName,
    required this.email,
    required this.password,
    required this.profilePhoto,
  });

  // Convert student object to a map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'studentID': studentID,
      'institutionName': institutionName,
      'email': email,
      'password': password,
      'profilePhoto': profilePhoto,
    };
  }

  @override
  String toString() {
    return '''
      Name: $firstName $lastName
      Student ID: $studentID
      Institution: $institutionName
      Email: $email
      Password: $password
      Profile Photo: $profilePhoto
    ''';
  }
}

void main() {
  Student student1 = Student(
    firstName: 'John',
    lastName: 'Doe',
    studentID: '123456',
    institutionName: 'ABC University',
    email: 'john.doe@example.com',
    password: 'password123',
    profilePhoto: 'profile_image.jpg',
  );

  print(student1.toString());
}
