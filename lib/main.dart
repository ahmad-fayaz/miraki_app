import 'package:flutter/material.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/firebase_options.dart';
import 'package:miraki_app/router/router.dart';
import 'package:miraki_app/screens/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MaterialApp(
      title: 'Our Miraki',
      theme: ThemeData(
          primarySwatch: materialPrimaryColor,
          scaffoldBackgroundColor: AppColor.light),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return const MyHomePage(title: 'Welcome to Our Miraki');
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Text('Loading');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
