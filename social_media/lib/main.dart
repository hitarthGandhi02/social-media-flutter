
import 'package:flutter/material.dart';
import 'package:social_media/Home.dart';
import 'package:social_media/firebase_auth.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/injection_container.dart';
import 'package:social_media/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
    theme:  ThemeData(fontFamily: 'Poppins'),
      home: locator<authService>().logged() ? Home() : Onboarding(),
    );
  }
}
