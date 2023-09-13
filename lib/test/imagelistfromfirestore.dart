import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../config/myconfig.dart';

class ImageListFromFirestore extends StatefulWidget {
  @override
  _ImageListFromFirestoreState createState() => _ImageListFromFirestoreState();
}

class _ImageListFromFirestoreState extends State<ImageListFromFirestore> {
  final firestore = FirebaseFirestore.instance.collection('courses');
   
  @override
  Widget build(BuildContext context) {
    
    MyConfig.assetFromFirebase = true;

    return Scaffold(
      appBar: AppBar(title: Text("Liste d'images")),
      body: StreamBuilder(
        stream: firestore.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> images = [];
          for (var doc in snapshot.data!.docs) {
            String imagePath = doc.get('imagePath');
            // Widget imageWidget = FutureBuilder(
            //   future: _getImageFromFirebaseStorage(imagePath),
            //   builder: (context, AsyncSnapshot<Image> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return snapshot.data!;
            //     } else if (snapshot.connectionState == ConnectionState.none) {
            //       return Text('Erreur lors du chargement de l\'image.');
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //   },
            // );
            Widget imageWidget = MyConfig.getImage(imagePath,76);
            images.add(imageWidget);
          }

          return ListView(
            children: images,
          );
        },
      ),
    );
  }

  // Inutile présentement
  String getImageCompleteUrl(String imageNameAndPath,bool firebaseStorageUsed){
    if (firebaseStorageUsed) {
      String replaced = imageNameAndPath.replaceAll('/', '%2F');
      return 'https://firebasestorage.googleapis.com/v0/b/cours-en-ligne-9a9e7.appspot.com/o/$replaced?alt=media&token=455da142-c24e-409e-9bd2-fc5cb005650a';
    }
    return imageNameAndPath;
  }

  // Inutile présentement
  Future<Image> _getImageFromFirebaseStorage(String imagePath) async {
    
    final storage = FirebaseStorage.instance;
    final imageUrl = await storage.ref(imagePath).getDownloadURL();
    return Image.network(imageUrl);
  }

  // Inutile présentement
  Future<Image> _getImage(String imagePath) async {
    return await Image.network(
    imagePath,
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      // Retournez une image d'erreur ou un autre widget si le chargement échoue
      return Icon(Icons.error);
    });
  }

  // Exemple de json dans l'HTTP request pour un image dans firebase storage
  // {
  // "name": "images_store/581-448-AH.png",
  // "bucket": "cours-en-ligne-9a9e7.appspot.com",
  // "generation": "1694406065188998",
  // "metageneration": "1",
  // "contentType": "image/png",
  // "timeCreated": "2023-09-11T04:21:05.190Z",
  // "updated": "2023-09-11T04:21:05.190Z",
  // "storageClass": "STANDARD",
  // "size": "76635",
  // "md5Hash": "pdj/ZD5+grGxgzhLDNbuFQ==",
  // "contentEncoding": "identity",
  // "contentDisposition": "inline; filename*=utf-8''581-448-AH.png",
  // "crc32c": "RupdMw==",
  // "etag": "CIbh+7zaoYEDEAE=",
  // "downloadTokens": "455da142-c24e-409e-9bd2-fc5cb005650a"
  // }

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print("Flutter Web");
    const FirebaseOptions webOption = FirebaseOptions(
        apiKey: "AIzaSyDkQco911uDpu-tzwOHOwiOUI3EPy68hP4",
        authDomain: "cours-en-ligne-9a9e7.firebaseapp.com",
        projectId: "cours-en-ligne-9a9e7",
        storageBucket: "cours-en-ligne-9a9e7.appspot.com",
        messagingSenderId: "977641602143",
        appId: "1:977641602143:web:5380832f9e5b64b261efea",
        measurementId: "G-EQRNY54G6W");
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
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageListFromFirestore(),
    );
  }
}
