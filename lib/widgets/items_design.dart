import 'package:flutter/material.dart';
import 'package:foodie/mainScreens/itemsScreen.dart';
import 'package:foodie/model/items.dart';
import 'package:foodie/model/menus.dart';

class ItemsDesignWidget extends StatefulWidget{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget>{
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,//280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 10.0,),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Train",
                )
              ),
              // ignore: avoid_unnecessary_containers
              const SizedBox(height: 10.0,),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl!,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.cover,
                    //size: Size.fromRadius(48),
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          )
        )
      )
    );
  }
}