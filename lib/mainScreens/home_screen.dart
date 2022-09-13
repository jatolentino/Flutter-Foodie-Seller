import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/authentication/auth_screen.dart';
import 'package:foodie/model/menus.dart';
import 'package:foodie/uploadScreens/menus_upload_screen.dart';
import 'package:foodie/widgets/info_design.dart';
import 'package:foodie/widgets/my_drawer.dart';
import 'package:foodie/widgets/progress_bar.dart';
import 'package:foodie/widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyDrawer(),
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
            icon: const Icon(Icons.post_add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MenusUploadScreen()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverToBoxAdapter(
          //   child: ListTile(
          //     title: Text(
          //       "My Menus",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontFamily: "Signatra",
          //         fontSize: 30,
          //         letterSpacing: 2,
          //         color: Colors.white,
          //       )
          //     ),
          //   ),
          // ),
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "My Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection("sellers")
              .doc(sharedPreferences!.getString("uid"))
              .collection("menus")
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
                    Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return InfoDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  );
            },
          )
        ]
      ),
    );
  }
}