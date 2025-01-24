import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/AddInfo.dart';
import 'package:flutter_application_1/screens/HomePage.dart';
import 'package:flutter_application_1/screens/RentPPage.dart';
import 'package:flutter_application_1/screens/RoomInfo.dart';
import 'package:flutter_application_1/screens/Signin.dart';
import 'package:flutter_application_1/screens/edit.dart';



Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:LoginPage(),
      routes: {
        '/rooms-info':(context)=> RoomInfo(),
        '/add-info' :(context)=>AddPage(),
        '/edit-room':(context)=>EditRoom(),
        '/rent-page':(context)=>RentPage()
        
      },
    );
  }
}