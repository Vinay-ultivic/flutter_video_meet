import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_meet/screen/sign_up_Screens/phone_verify.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void authenticationPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(210, 23, 85, 20),
                Color.fromRGBO(253, 186, 130, 20)]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new)),),
        body: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                Column(
                  children: [
                    Image.asset(
                    "assets/images/influencer.png",
                    height: MediaQuery.of(context).size.height/4,
                  ),
                    Text("Sign Up",style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.height/20
                    ),),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0,right: 40),
                  child: Column(children: [
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(28),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          contentPadding: EdgeInsets.all( MediaQuery.of(context).size.height/60),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all( 18.0),
                            child: Icon(Icons.account_circle,color: Colors.pinkAccent,),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20,),
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(28),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height/60),

                          prefixIcon: const Padding(
                            padding: EdgeInsets.all( 18.0),
                            child: Icon(Icons.key_rounded,color: Colors.pinkAccent,),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          disabledBorder: InputBorder.none,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20,),
                    /// Lets start button--->
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () async{
                            FirebaseAuth auth = FirebaseAuth.instance;


                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91 ${emailController.text}',
                            verificationCompleted: (PhoneAuthCredential credential) async {
                              await auth.signInWithCredential(credential);

                            },
                            verificationFailed: (FirebaseAuthException e) {
                              if (e.code == 'invalid-phone-number') {
                                debugPrint('The provided phone number is not valid.');
                              }
                            },
                            codeSent: (String verificationId, int? resendToken) async {
                        //      Navigator.push(context, MaterialPageRoute(builder: (context) =>  PhoneVerify(verificationId: verificationId,),));

                       /*
                              String smsCode = 'xxxx';

                              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                              // Sign the user in (or link) with the credential
                              await auth.signInWithCredential(credential);*/
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              debugPrint("<---codeAutoRetrievalTimeout--->$verificationId");

                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 80,right: 80,top: 20,bottom: 20),
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],),
                )
              ],),
          ),
        ),
      ),
    );
  }
}
