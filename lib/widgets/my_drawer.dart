import 'package:flutter/material.dart';
import 'package:foodie/authentication/auth_screen.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/mainScreens/earnings_screen.dart';
import 'package:foodie/mainScreens/history_screen.dart';
import 'package:foodie/mainScreens/home_screen.dart';
import 'package:foodie/mainScreens/new_orders_screen.dart';

class MyDrawer extends StatelessWidget{ //important to set to true in homescreen automaticallyImplyLeading: true, OR SIMPLY DETELETE THE FALSE STATEMENT

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [ //header drawer
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:10,),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                // Divider(
                //   height: 10,
                //   color: Colors.grey,
                //   thickness: 2,
                // ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.red,),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.red,),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningsScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.red,),
                  title: const Text(
                    "New Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> NewOrdersScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.red,),
                  title: const Text(
                    "History - Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.red,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));
                    });
                  },
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}