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

  // Factory method to create a Student object from a map
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['firstName'],
      lastName: json['lastName'],
      studentID: json['studentID'],
      institutionName: json['institutionName'],
      email: json['email'],
      password: json['password'],
      profilePhoto: json['profilePhoto'],
    );
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
