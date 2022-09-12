import 'package:flutter/material.dart';
import 'package:foodie/mainScreens/itemsScreen.dart';
import 'package:foodie/model/menus.dart';

class InfoDesignWidget extends StatefulWidget{
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget>{
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
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
              const SizedBox(height: 20.0,),
              // ignore: avoid_unnecessary_containers
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
              const SizedBox(height: 2.0,),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Train",
                )
              ),
              Text(
                widget.model!.menuInfo!,
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