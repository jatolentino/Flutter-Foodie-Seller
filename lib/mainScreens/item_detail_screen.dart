import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/assistantMethods/assistant_methods.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/model/items.dart';
import 'package:foodie/splashScreen/splash_screen.dart';
//import 'package:foodie/widgets/app_bar.dart';
import 'package:foodie/widgets/simple_app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
//import 'package:number_inc_dec/number_inc_dec.dart';

class ItemDetailsScreen extends StatefulWidget{
  
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();

}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  // addItemToCart(String foodItemId, BuildContext context, int itemCounter){

  // }
  deleteItem(String itemID)
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete().then((value)
    {
      FirebaseFirestore.instance
          .collection("items")
          .doc(itemID)
          .delete();

      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
      Fluttertoast.showToast(msg: "Item Deleted Successfully.");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: sharedPreferences!.getString("name"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.price.toString() + "\$",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),

          const SizedBox(height: 60,),
          Center(
            child: InkWell(
              onTap: (){
                deleteItem(widget.model!.itemID!);
              },
              child: Container(
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
                  ),
                ),
                width: MediaQuery.of(context).size.width - 150,
                height: 50,
                child: const Center(
                  child: Text(
                    "Delete this item",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}