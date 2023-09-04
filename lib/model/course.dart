
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
      imagePath: "assets/images/png_img_empty_2.png", // Assurez-vous que le chemin est correct
      code: ""
    );
  }

}

// Ensuite, vous pouvez créer une instance de la classe Cours en utilisant le constructeur, en fournissant les valeurs appropriées pour chaque attribut :
void main() {
  Course monCours = Course(
    title: "Cours sur les réseaux",
    description: "Apprenez tout sur les réseaux informatique",
    imagePath: "assets/images/ex_cours2.jpeg", // Assurez-vous que le chemin est correct
    code: "1"
  );

  print(monCours.toString());
}






