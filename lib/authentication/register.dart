import 'package:flutter/material.dart';
import 'package:foodie/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; //for adding the file
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:foodie/widgets/error_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}): super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position? position;
  List<Placemark>? placeMarks;

  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  LocationPermission? permission;

  getCurrentLocation() async{ //add geocoidng and geolocator packages
    permission = await Geolocator.requestPermission();

    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark pMark = placeMarks![0];
    String completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    locationController.text = completeAddress;
  }

  Future<void> formValidation() async{
    if (imageXFile == null){
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog(
            message: "Please select an image",
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            InkWell( //add image on the profile icon
              onTap: (){
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.2,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile==null ? null: FileImage(File(imageXFile!.path)),
                child: imageXFile == null ? 
                Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ) : null,
              ),
            ),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                    isObsecre: false,
                  ),
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
                  CustomTextField(
                    data: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.phone,
                    controller: phoneController,
                    hintText: "Phone",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.my_location,
                    controller: locationController,
                    hintText: "Cafe/Restaurant address",
                    isObsecre: false,
                    enabled: true,
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      label: const Text(
                        "Get my current Location",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        getCurrentLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, //red.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30,),
            // ElevatedButton(
            //   child: const Text(
            //     "Sign up",
            //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.red,
            //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            //   ),
            //   onPressed: () {
            //     formValidation();
            //   },
            // ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.shade300,
                    Colors.red.shade300,
                  ],
                  begin: const FractionalOffset(0.0, 0.5),
                  end: const FractionalOffset(1.0, 0.5),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    //onSurface: Colors.transparent,
                ),
                onPressed: (){
                  formValidation();
                }, 
                child: Padding(
                  // padding:EdgeInsets.only(
                  //   top: 1,
                  //   bottom: 1,
                  // ),
                  padding: EdgeInsets.symmetric(horizontal: 30,
                    vertical: 10),
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),  
            ),
            const SizedBox(height: 30,),
          ]
        )
      )
    );
  }
}