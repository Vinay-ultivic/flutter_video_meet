import 'package:agora_token_service/agora_token_service.dart';
import 'package:flutter/material.dart';
import 'package:video_meet/main.dart';
import 'package:video_meet/screen/sign_up_Screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/influencer.png",
                  height: MediaQuery.of(context).size.height / 4,
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Text(
                  "WELCOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 20),
                ),
                const SizedBox(height: 5,),
                const Text(
                  "Video Meet is video call app",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "where you can make video call to other person",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "We help to connect people",
                  style: TextStyle(
                    color: Colors.white,

                  ),
                ),
              ],
            ),

            /// Lets start button--->
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 80,right: 80,top: 20,bottom: 20),
                    child: Text(
                      "LET'S START",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
