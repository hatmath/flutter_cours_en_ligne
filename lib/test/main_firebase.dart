import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    print("Flutter Web");    
    // Votre logique spécifique pour le Web ici
    const FirebaseOptions webOption = FirebaseOptions(
      apiKey: "AIzaSyA4u2Z2oiqbOuyNpYWdWcGSqyNDhuK6xFY",
      authDomain: "exercices-flutter.firebaseapp.com",
      projectId: "exercices-flutter",
      storageBucket: "exercices-flutter.appspot.com",
      messagingSenderId: "399288472806",
      appId: "1:399288472806:web:a36ebd644c191217831727",
      measurementId: "G-N4YWPVQQCJ"
    );
    await Firebase.initializeApp(
      options: webOption,
    );
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    print("Flutter Android");
    // Votre logique spécifique pour Android ici
     await Firebase.initializeApp();
  }
 
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List with Hero Transition'),
      ),
      body: ItemList()
    );
  }
}

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('items').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final item = documents[index].get("name");

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(item: item),
                  ),
                );
              },
              child: ListTile(
                leading: Hero(
                  tag: 'item_$item',
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                title: Text(item),
              ),
            );
          },
        );
      },
    );
  }
}


class DetailScreen extends StatelessWidget {
  final String item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Hero(
          tag: 'item_$item',
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              item,
              style: TextStyle(color: Colors.white),
            ),
            radius: 50,
          ),
        ),
      ),
    );
  }
}
