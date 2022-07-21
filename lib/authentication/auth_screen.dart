import 'package:flutter/material.dart';
import 'package:foodie/authentication/login.dart';
import 'package:foodie/authentication/register.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}): super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient( //const linearGradient
                colors: [
                  Colors.pink.shade400,
                  Colors.red.shade400,
                ],
                begin: const FractionalOffset(0.0, 0.5),
                end: const FractionalOffset(1.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "Foodie",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontFamily: "Lobster",
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white,),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 7,
          )
        ),
        body: Container(
          child: TabBarView(
            children: [
             LoginScreen(),
             RegisterScreen(),
            ],
          ),
        )
      ),
    );
  }
}