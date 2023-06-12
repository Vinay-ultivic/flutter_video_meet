import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:video_meet/screen/home_screen.dart';

class PhoneVerify extends StatefulWidget {
  String verificationId = "";
  String phoneNumber="";

  PhoneVerify({Key? key, required this.verificationId,
  required this.phoneNumber
  }) : super(key: key);

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  String otp = "";

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";
  late StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: const Text("OTP Verification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Enter verification code",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "We sent an",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                " SMS ",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              ),
              Text(
                "with a code to verify your ",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Center(
            child: Text(
              "phone number",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text("+91"),
              const SizedBox(
                width: 2,
              ),
              Text(widget.phoneNumber),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40.0, horizontal: 5),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w100,
                    ),
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    validator: (v) {
                      /* if (v?.length <= 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }*/
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        activeFillColor: hasError ? Colors.white : Colors.white,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        disabledColor: Colors.white),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    textStyle: const TextStyle(fontSize: 20, height: 1.6),
                    //   backgroundColor: Colors.grey.shade100,
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.grey,
                        blurRadius: 5,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        //    currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");

                      return true;
                    },
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async{
              FirebaseAuth auth = FirebaseAuth.instance;

              final credentials = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: textEditingController.text);
              try{
                await auth.signInWithCredential(credentials);


                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomeScreen(),));

              }catch(e){
                debugPrint("<---error-->$e");

              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 15,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.pinkAccent),
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
         /* const SizedBox(
            height: 60,
          ),
          const Text(
            "I did't get Code",
            style: TextStyle(
                color: Colors.pinkAccent, fontWeight: FontWeight.w900),
          )*/
        ],
      ),
    );
  }
}
