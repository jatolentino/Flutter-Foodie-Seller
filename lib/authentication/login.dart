import 'package:flutter/material.dart';
import 'package:foodie/authentication/auth_screen.dart';
import 'package:foodie/widgets/custom_text_field.dart';
import 'package:foodie/widgets/error_dialog.dart';
import 'package:foodie/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/mainScreens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}): super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();  

  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      //login
      loginNow();
    }
    else
    {
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog( 
            message: "Please write email/password.",
          );
        }
      );
    }
  }

  loginNow() async{
    showDialog(
      context: context,
      builder: (c){
        return LoadingDialog(
          message: "Checking Credentials",
        );
      }
    );

    User? currentUser;
    try {
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    });
    }  on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
         }
      );
    };


    // if(currentUser != null){
    //   readDataAndSetDataLocally(currentUser!).then((value){
    //     Navigator.pop(context);
    //     Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
    //   });
    // }
    if(currentUser != null){ //After successful login send rider to the home screen
      readDataAndSetDataLocally(currentUser!);//.then((value){
      //readDataAndSetDataLocally(currentUser!).then((value){
        //Navigator.pop(context);
        //Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen())); min 45 (vid 22-26)
      //});
    }
  }
  
  // Future readDataAndSetDataLocally(User currentUser) async{
  //   await FirebaseFirestore.instance.collection("sellers") //add firebase cloud package
  //     .doc(currentUser.uid)
  //     .get()
  //     .then((snapshot) async {
  //       await sharedPreferences!.setString("uid", currentUser.uid);
  //       await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
  //       await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
  //       await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
  //     });
  // }

  Future readDataAndSetDataLocally(User currentUser) async{
    await FirebaseFirestore.instance.collection("sellers") //checking if the user that is login is the riders collection //add firebase cloud package
      .doc(currentUser.uid)
      .get()
      .then((snapshot) async {
        if(snapshot.exists)
        {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
          await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        }
        else
        {
          firebaseAuth.signOut();
          sharedPreferences!.clear(); //added this, once you logout, sharedpreferences or cache data will be deleted
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "User not identified"
              );
            }
          );
        }
      });
  }
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "images/seller.png",
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            )
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: (){
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}