import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_meet/screen/home_screen.dart';
import 'package:video_meet/screen/sign_up_Screens/welcome_screen.dart';

///<------------------------- Variables---------------------------------------->

const appId = "8e2e692ceb854f15ad24a975e34eac82";
const token = "007eJxTYGhRko1zjLq5IkT+SuWlP7sWtT1Ul29fU1GYE7/yzJJvoVUKDBapRqlmlkbJqUkWpiZphqaJKUYmiZbmpqnGJqmJyRZGBqLtKQ2BjAyK27qZGBkgEMRnYUhJzc1nYAAAe88fuw==";
const channel = "demo";

 bool remember = false;
User? user = FirebaseAuth.instance.currentUser;
FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
debugPrint("<-----USER---->$user");
  if(user!=null){
    remember=true;
  }
  else{
    remember=false;
  }
  runApp(MaterialApp(
      home: remember ? const MyHomeScreen() : const WelcomeScreen()
  )
  );
}
