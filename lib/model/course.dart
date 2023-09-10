
class Course {
  final String title;
  final String description;
  final String imagePath;
  final String code;
  final String language = "french";

  Course({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.code,
  });

  // Constructeur nommé qui accepte un Map<String, dynamic>
  Course.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        description = map['description'] ?? '',
        imagePath = map['imagePath'] ?? 0, 
        code = map['code'] ?? '';

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        title: json['title'],
        description: json['description'],
        imagePath: json['imagePath'],
        code: json['code']);
  }

  @override
  String toString() {
    if (language == "french") {
      return "code: $code\ntitre: $title\ndescription: $description\ncheminImage: $imagePath";
    } else {
      return "code: $code\ntitle: $title\ndescription: $description\nimagePath: $imagePath";
    }
    
  }

  static Course getEmptyCourse() {
    return Course(
      title: "",
      description: "",
      imagePath: "assets/images/png_transparent.png", // Assurez-vous que le chemin est correct
      code: ""
    );
  }

}




