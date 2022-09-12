import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/mainScreens/home_screen.dart';
import 'package:foodie/model/menus.dart';
import 'package:foodie/widgets/error_dialog.dart';
import 'package:foodie/widgets/progress_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class ItemsUploadScreen extends StatefulWidget {

  final Menus? model;
  ItemsUploadScreen({this.model});

  @override
  _ItemsUploadScreenState createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {

  XFile? imageXFile; //package image_picker
  final ImagePicker _picker = ImagePicker();
  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen(){
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
        title: const Text(
          "Add New Items",
          style: const TextStyle(fontSize: 25, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));          
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shop_two, color: Colors.grey, size: 200.0,),
              ElevatedButton(
                child: const Text(
                  "Add New Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: (){
                  takeImage(context);
                },
              ),
            ],
          )
        )
      )
    );
  }
  
  takeImage(mContext){
    return showDialog(
      context: mContext,
      builder: (context)
      {
        return SimpleDialog(
          title: const Text("Item Image", style: TextStyle(color: Colors.red, fontWeight:FontWeight.bold),),
          children: [
            SimpleDialogOption(
              child: const Text(
                "Capture with Camera",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: const Text(
                "Select from Gallery",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: ()=> Navigator.pop(context),
            ),
          ]
        );
      },
    );
  }
  
  captureImageWithCamera() async{
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async{
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }
  
  itemsUploadFormScreen(){
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
        title: const Text(
          "Uploading New Item",
          style: TextStyle(fontSize: 25, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,),
          onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));          
            clearItemsUploadForm();
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: "Varela",
                letterSpacing: 1,
              ),
            ),
            onPressed: uploading ? null : ()=> validateUploadForm(),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30,),
          uploading == true ? linearProgress() : const Text(""), ////////////
          Container(
            height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), //Added a radius
                    image: DecorationImage(
                      image: FileImage(
                        File(imageXFile!.path) // import 'dart:io';
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              )
            )
          ),
          const SizedBox(height: 30,),
          ListTile(
            leading: const Icon(Icons.title, color: Colors.red),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Item title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.perm_device_information, color: Colors.red),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "Item info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.description, color: Colors.red),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Item description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on, color: Colors.red),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: "Item price",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  clearItemsUploadForm(){
    setState((){
      shortInfoController.clear();
      titleController.clear();
      priceController.clear();
      descriptionController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async{
    if(imageXFile != null){
      if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && priceController.text.isNotEmpty){
        setState(() {
          uploading = true;
        });
        // upload image and save info to the firebase
        String downloadUrl = await uploadImage(File(imageXFile!.path));
        saveInfo(downloadUrl);
      }
      else{
        showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "Please write a title and information for the item",
            );
          }
        );
      }
    }
    else{
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog(
            message: "Please pick an image for the item"
          );
        }
      );

    }


  }

  saveInfo(String downloadUrl){
    final ref = FirebaseFirestore.instance
      .collection("sellers")
      .doc(sharedPreferences!.getString("uid"))
      .collection("menus").doc(widget.model!.menuID) //items as a subcollection of menus
      .collection("items");
    
    ref.doc(uniqueIdName).set({
      "itemID": uniqueIdName,
      "menuID": widget.model!.menuID,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text.toString(),
      "longDescription": descriptionController.text.toString(),
      "price": int.parse(priceController.text),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    }).then((value)
    {
      final itemsRef = FirebaseFirestore.instance
        .collection("items");
      itemsRef.doc(uniqueIdName).set({
        "itemID": uniqueIdName,
        "menuID": widget.model!.menuID,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "longDescription": descriptionController.text.toString(),
        "price": int.parse(priceController.text),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
      });
    }).then((value){
      clearItemsUploadForm();
      setState((){
        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    });

    
  }
  uploadImage(mImageFile) async{
    storageRef.Reference reference = storageRef.FirebaseStorage
      .instance
      .ref()
      .child("items");
    storageRef.UploadTask uploadTask = reference.child(uniqueIdName + ".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }
  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : itemsUploadFormScreen();
  }
}