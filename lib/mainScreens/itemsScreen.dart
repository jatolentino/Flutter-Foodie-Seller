import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/model/items.dart';
import 'package:foodie/model/menus.dart';
import 'package:foodie/uploadScreens/items_upload_screen.dart';
import 'package:foodie/uploadScreens/menus_upload_screen.dart';
import 'package:foodie/widgets/items_design.dart';
import 'package:foodie/widgets/my_drawer.dart';
import 'package:foodie/widgets/progress_bar.dart';
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
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My " + widget.model!.menuTitle.toString() + "'s Items")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("sellers")
              .doc(sharedPreferences!.getString("uid"))
              .collection("menus")
              .doc(widget.model!.menuID)
              .collection("items")
              .orderBy("publishedDate", descending: true)
              .snapshots(),
            builder: (context, snapshot){
              return !snapshot.hasData
                ? SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),
                  )
                : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index){
                    Items model = Items.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return ItemsDesignWidget(
                      model: model, // Is gonna get fixed with iterms.design.dart
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  );
            },
          ),        
        ]
      )
    );
  }
}