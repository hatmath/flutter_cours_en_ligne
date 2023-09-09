import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../view/myhomepage.dart';
import '../config/myconfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  MySplashScreenState createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _startTransition();
    });
  }

  void _startTransition() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (_, __, ___) => const MySplashScreenNextPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/png_img.png', width: 150),
            const SizedBox(height: 20),
            Image.asset('assets/images/gif_img.gif', width: 150),
          ],
        ),
      ),
    );
  }
}

class MySplashScreenNextPage extends StatelessWidget {
  const MySplashScreenNextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyConfig.getNextPage(); // Appelez simplement MyHomePage()
  }
}