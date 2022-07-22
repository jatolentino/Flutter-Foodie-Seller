# Foddie app

This app has the following features:

## Result of the project
This is the final result of the projected obtained @ the step 11 that belongs to the [`ver-1.4`]()

<!-- <p align="center">
    	<img src="https://github.com/jatolentino/Foodie/.../file.png" width="400">
</p>

<br> -->

## How to run the project?

<!-- - Clone the repository and open the terminal and navigate to the `ios` folder, then run:

    ```bash
    flutter pub add firebase_auth
    flutter pub add firebase_core
    //sudo gem install cocoapods
    flutter pub get
    pod install
    ``` -->


<!-- 
- Configure the firebase database, following the Step 8 (`Create a firebase project`).
- Enjoy! -->

## Follow along

### 1. Getting Started

- Create the project, in the terminal run:
    ```bash
    flutter create --org com.app foodie
    ```
  > Bundle ID will be: `com.app.foodie`, the name of the project is added by default at the end of `com.app`

- Open VSCODE and open the folder `foodie` just created
- Navigate to the Source Control icon on VSCODE and choose the option `Publish to Github`, then enter your credentials and set the name of the repo (Flutter-Foodie).

- Add the assets and images folder to the root of the project (`/foodie/`)
- Configure the pubspec.yaml file as:
    ```yaml
    name: foodie
    description: A new Flutter project.
    version: 1.0.0+1
    environment:
    sdk: ">=2.17.5 <3.0.0"

    dependencies:
        flutter:
            sdk: flutter

    cupertino_icons: ^1.0.2
    image_picker: ^0.8.5+3

    dev_dependencies:
        flutter_test:
            sdk: flutter
        flutter_lints: ^2.0.0

    flutter:
        uses-material-design: true
        assets:
            - images/
        fonts:
            - family: Bebas
                fonts:
                    - asset: assets/fonts/BebasNeue-Regular.ttf
            - family: Lobster
                fonts:
                    - asset: assets/fonts/Lobster-Regular.ttf
            - family: Signatra
                fonts:
                    - asset: assets/fonts/Signatra.ttf
            - family: Varela
                fonts:
                    - asset: assets/fonts/VarelaRound-Regular.ttf 
    ```

### 2. Edit the lib/main.dart file

```dart
import 'package:flutter/material.dart';
import 'package:foodie/splashScreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sellers App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

### 3. Add the splashcreen
- Create a splashScreen in lib/ and inside the file splash_screen.dart
```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:foodie/authentication/auth_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}): super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
    Timer(const Duration(seconds: 4), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.jpg"),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Sell Food Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 4. Add the splashcreen
- Create the lib/authentication folder
- Create the authorization_screen.dart in lib/authentication, this file will contain the login/register widgets

    ```dart
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
    ```
### 5. Create the register and login dart files 
- Create the register.dart file in the lib/authorization folder

```dart
import 'package:flutter/material.dart';
import 'package:foodie/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; //for adding the file

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

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            InkWell(
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
                  ),
                ],
              ),

            ),
          ]
        )
      )
    );
  }
}
```

### 6. Create the custom_text_field widget
- Create the folder widgets, and inside there create the file custom_text_field.dart

```dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecre,
    this.enabled,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      //padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(left: 30, top:10, right: 30, bottom:5),
      //margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.pink.shade300,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText:hintText,
        ),
      ),
    );
  }
}
```

Test 6.1: In the terminal run:
```bash
flutter pub get
```
Compiled @ the branch of [`ver-1.0`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.0)
    <p align="center">
    	<img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.0/sources/step6-test-1%2C1.jpeg" width="250"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.0/sources/step6-test-1%2C2.png" width="250">        
    </p>

### 7. Add `Get my location` button 
- In the register.dart file, add the button `Get my location` in order to let users pick a location from google maps to register their businesses' address.
- Add the getCurrentLocation() and import the packages geocoding.dart & geolocator.dart
- Add the _getImage async function to permit users upload their profile photo via the package image_picker ( `'package:image_picker/image_picker.dart'`)
<!-- 
  ```dart
    :
    CustomTextField(),
    CustomTextField(),
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
  ```

- Create the asyn function getCurrentLocation() in lib/authentication/register.dart

  ```dart
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
  ``` -->

```dart
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
                ),
                onPressed: (){
                  formValidation();
                }, 
                child: Padding(
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
```

### 8. Configure the geolocator, geocoding and image_picker
- In the pubspec.yaml file add:
```yaml
  dependencies:
    flutter:
      sdk: flutter

    cupertino_icons: ^1.0.2
    image_picker: ^0.8.5+3
    geolocator: ^9.0.1
    geocoding: ^2.0.4
```
- In foodie/android/gradle.properties makes sure the properties are already there
  ```gradle
  android.useAndroidX=true
  android.enableJetifier=true
  ```

- Change the compliSdkVersion in foodie/android/app/src/build.gradle according to the geolocator suggestion in `https://pub.dev/packages/geolocator`

  ```grade
  android {
    //compileSdkVersion flutter.compileSdkVersion
    compileSdkVersion 33
    ndkVersion flutter.ndkVersion
  ```

- In foodie/andoird/app/src/main/ edit the AndroidManifest.xml

  ```xml
  <manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="com.app.foodie">

      <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
      <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
      :
  ```

- In foodie/ios/Runner/info.plist

  ```plist
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>NSLocationWhenInUseUsageDescription</key>
      <string>This app needs access to location when open.</string>
      <key>NSLocationAlwaysUsageDescription</key>
      <string>This app needs access to location when in the background.</string>
  ```

- Run `flutter pub dev` to install the dependecies just added (geolocator, geocoding, imagepicker)

  > -To change the emulator location, go to the device settings > Apps & Notifications > (Advanced>) Permission Manager > Location, and add the app and Google maps so that they have rights to use the Location property <br>
  > -Also, open google maps and verify that it can show the actual location <br>
  > -Finally, if it's necessary to change the location to any point in the map so that the emulator picks that point as the actual location, tap on the three dots of the emulator > Location, and seach for any desired address and choose the `Set Location` option

### 9. Complete the login screen
- In lib/authentication create the login.dart file
```dart
import 'package:flutter/material.dart';
import 'package:foodie/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}): super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();  

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "images/seller.png",
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
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
              ],
            )
          ),
          ElevatedButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: ()=> print("clicked"),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
```

### 10. Configure firebase
- Go to console.firebase.google.com and `Add project`
- Assign a name for the project: Food App
- Disable: `Enable Google Analytics tor this project` and hit on `Continue`
- Navigate to Build > Authentication and hit on `Get started`, choose the `Email/Password` sign-in method
- Navigate to Build > Firestore Database and click on `Create database`, choose the `Start in test mode` option, then `Next` and `Enable`
  - Go to the `Rules` tab and edit it as:
    ```CEL
    rules_version = '2';
    service cloud.firestore {
      match /databases/{database}/documents {
        match /{documents=**} {
          allow read, write: if true;
        }
      }
    }
    ```
  - Then hit on `Publish`

- Navigate to Build > Storage and go to the `Rules` tab and edit it as:
  ```CEL
  rules_version = '2';
  service firebase.storage {
    match /b/{bucket}/o {
      match /allPaths=**} {
        allow read, write: if request.auth != null;
      }
    }
  }
  ```
- Head to Project Overview tab and click on the gear icon, to configure the app
  - In the Project settings, go to the tab `General` and provide a Support email
  - In your apps section, choose the Android icon to configure it.
  - Type the Android package name as stablished at the moment of creating the app in the Step 1: `com.app.foodie`
  - Choose a nickname like: `Seller app`
  - Finish with `Register app`
  - Download the google-services.json and paste it on `foodie/android/app`
  - Edit the foodie/android/build.gradle and add
    ```gradle
    dependencies {
      classpath 'com.google.gms:google-services:4.3.13'
      :
    ```
  - Edit the foodie/android/app/build.gradle and add at the end
    ```gradle
    :
    apply plugin: 'com.google.gms.google-services'
    ```
  - Add firebase features (authentication, storage, cloud and core) into the dependencies to pubspec.yaml
  
    ```yaml
    dependencies:
      flutter:
        sdk: flutter

      firebase_core: ^1.20.0
      firebase_auth: ^3.5.0
      cloud_firestore: ^3.4.0
      firebase_storage: ^10.3.3
      cupertino_icons: ^1.0.2
      firebase_core: 
      image_picker: ^0.8.5+3
      geolocator: ^9.0.1
      geocoding: ^2.0.4
    ```
  
### 10. Udate the firebase package to main.dart

- In lib/main.dart

  ```dart
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:foodie/splashScreen/splash_screen.dart';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Sellers App',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const MySplashScreen(), //const MyHomePage(title: 'Flutter Demo Home Page'),
      );
    }
  }
  ```

### 11. Create a error message widget

- In lib/widgets/ create the error_dialog.dart file that can show alert messages with custom inputs

  ```dart
  import 'package:flutter/material.dart';

  class ErrorDialog extends StatelessWidget{
    final String? message;
    ErrorDialog({this.message});

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        key: key,
        content: Text(message!),
        actions: [
          ElevatedButton(
            child: const Center(
              child: Text("ok"),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  }
  ```
Test 11.1: In the Register tab of the app, click on Sign up without uploading a photo profile. A popup message should appear.

Compiled @ the branch of [`ver-1.1`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.1)

<p align="center">
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.1/sources/step11-test-1.png" width="250">     
</p>
