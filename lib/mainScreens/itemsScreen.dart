import 'package:flutter/material.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/model/menus.dart';
import 'package:foodie/uploadScreens/items_upload_screen.dart';
import 'package:foodie/uploadScreens/menus_upload_screen.dart';
import 'package:foodie/widgets/my_drawer.dart';
import 'package:foodie/widgets/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {

  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 25, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.library_add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsUploadScreen(model: widget.model)));
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My " + widget.model!.menuTitle.toString() + "'s Items"))
        ]
      )
    );
  }
}