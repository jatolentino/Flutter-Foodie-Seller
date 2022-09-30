# Foddie Seller Mobile App for IOS and Android

This app has the following features:
- Login/Register System
- Firebase database integration
- Drawer Screen with tabs: Home, My earnings, New orders, History, Sign out
- Create, read, update, delete actions on menus and menu items


## Result of the project
The final result of this project belongs to the ver [`ver-1.5`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.5).
<p align="center">
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/final-1.jpeg" width="500">
</p><br/>

<p align="center">
 <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-1.jpeg" width="225">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-2.jpeg" width="225">
</p><br/>

<p align="center">
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/final-2.jpeg" width="600">
</p>

## How to run the project?

Clone the repository and open the terminal and navigate to the `ios` folder, then run:

    ```bash
    flutter pub add firebase_auth
    flutter pub add firebase_core
    //sudo gem install cocoapods
    flutter pub get
    pod install
    ```

- Configure the firebase database, following the link [`Step 9.1: Create a firebase project`](https://github.com/jatolentino/Flutter-Foodie#configure_firebase)

- Enjoy!


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
    name: foodie_riders
    description: A new Flutter project.
    publish_to: 'none' # Remove this line if you wish to publish to pub.dev

    version: 1.0.0+1

    environment:
      sdk: ">=2.17.5 <3.0.0"


    dependencies:
      flutter:
        sdk: flutter

      cupertino_icons: ^1.0.2
      firebase_core: ^1.20.0
      firebase_auth: ^3.5.0
      cloud_firestore: ^3.4.0
      firebase_storage: ^10.3.3
      image_picker: ^0.8.5+3
      geolocator: ^9.0.1
      geocoding: ^2.0.4
      shared_preferences: ^2.0.15

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

- Change the compliSdkVersion in foodie/android/app/build.gradle according to the geolocator suggestion in `https://pub.dev/packages/geolocator`

  ```grade
  android {
    //compileSdkVersion flutter.compileSdkVersion
    compileSdkVersion 33
    ndkVersion flutter.ndkVersion
    :
    defaultConfig {
        applicationId "com.app.foodie"
        minSdkVersion 19
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        multiDexEnabled true //multidex works with minsdkversion 19
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


Compiled @ the branch of [`ver-1.1`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.1)

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
<a id="configure_firebase"></a>
### 9.1. Configure the firebase

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
        allow read, write: if true
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
  
### 10. Update the firebase package to main.dart

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

### 11. Create an error message widget

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

Compiled @ the branch of [`ver-1.2`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.2)

<p align="center">
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.2/sources/step11-test-1.png" width="250">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.2/sources/step11-test-1-2.png" width="250">     
</p>

### 12. Registering account
- Adding a loading screen (loading_dialog.dart) in lib/widgets that contains a progress_bar.dart
  ```dart
  import 'package:flutter/material.dart';
  import 'package:foodie/widgets/progress_bar.dart';

  class LoadingDialog extends StatelessWidget{
    final String? message;

    LoadingDialog({this.message});

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        key: key,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            circularProgress(),
            SizedBox(height: 10,),
            Text(message! + ". Please wait..."),
          ],
        ),
      );
    }
  }
  ```

  For the progress_bar.dart
  ```dart
  import 'package:flutter/material.dart';
  import 'package:foodie/widgets/progress_bar.dart';

  class LoadingDialog extends StatelessWidget{
    final String? message;

    LoadingDialog({this.message});

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        key: key,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            circularProgress(),
            SizedBox(height: 10,),
            Text(message! + ". Please wait..."),
          ],
        ),
      );
    }
  }
  ```

- Uploading profile pic if there're no errors
- Registering the account
- Uploading users info to database
- Saving data locally for easy access, add `shared_preferences: ^2.0.15` to the pubscpec.yaml file, and add a global.dart file in lib/global containing the `sharedPrefernces`<br>

Edit: lib/authentication/register.dart
```dart
import 'package:flutter/material.dart';
import 'package:foodie/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; //for adding the file
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:foodie/widgets/error_dialog.dart';
import 'package:foodie/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/mainScreens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:foodie/global/global.dart';

//errors
// 1. register with a simple password, fials but profile pic already loaded
// 2. at deleting the user authentication in the firebase, storage and firestore doesnt get delete

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

  String sellerImageUrl = "";
  String completeAddress = "";

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
    completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
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
    else{
      if(passwordController.text == confirmPasswordController.text){

        if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && 
        nameController.text.isNotEmpty && phoneController.text.isNotEmpty && 
        locationController.text.isNotEmpty){
          showDialog(
            context: context,
            builder: (c){
              return LoadingDialog(
                message: "Registering Account",
              );
            }
          );

          
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("sellers").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;
            // finished the signup and proceed to mainScreen
            authenticateSellerAndSignUp();
          });
        }
        
        else{
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Please complete your information in every field",
              );
            }
          );
        }
      }
      else
      {
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Password does not match, please try again",
            );
          }
        );
      }
    }
  }

  void authenticateSellerAndSignUp() async{
    User? currentUser; 
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
    
    await firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    });
    }  on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
         }
      );
    };

    if(currentUser !=null){
      saveDataToFirestore(currentUser!).then((value){
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async{
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": nameController.text.trim(),
      "sellerAvatarUrl": sellerImageUrl,
      "phone": phoneController.text.trim(),
      "address": completeAddress,
      "status": "aproved",
      "earnings": 0.0,
      "lat": position!.latitude,
      "long": position!.longitude,
    });

    //Saving the data locally on the user's phone
    SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("uid", currentUser.uid);
    await sharedPreferences.setString("email", currentUser.email.toString());
    await sharedPreferences.setString("name", nameController.text.trim());
    await sharedPreferences.setString("photoUrl", sellerImageUrl);
  }

  @override
  :
  :
```
- Adding a splash_screen.dart to redirect users to home_screen.dart if they're signed in on to the authentication screen if they were not logged in successfully
```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:foodie/authentication/auth_screen.dart';
import 'package:foodie/mainScreens/home_screen.dart';
import 'package:foodie/global/global.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}): super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
    Timer(const Duration(seconds: 4), () async {
      //if seller is logged in
      if(firebaseAuth.currentUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      //if seller is not logged in
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }

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
### 13. Implement the home and login screens

- Create a home_screen.dart in lib/mainScreen
```dart
import 'package:flutter/material.dart';
import 'package:foodie/global/global.dart';
import 'package:foodie/authentication/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
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
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          style: ElevatedButton.styleFrom(
            primary: Colors.cyan,
          ),
          onPressed: (){
            firebaseAuth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));
            });
            
          },
        )
      )
    );
  }
}
```

- Editing main.dart to initialize the splash_screen
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie/splashScreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodie/global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sellers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

- Editing the login.dart file
```dart
import 'package:flutter/material.dart';
import 'package:foodie/authentication/auth_screen.dart';
import 'package:foodie/widgets/custom_text_field.dart';
import 'package:foodie/widgets/error_dialog.dart';
import 'package:foodie/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/mainScreens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}): super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();  

  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      //login
      loginNow();
    }
    else
    {
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog( 
            message: "Please write email/password.",
          );
        }
      );
    }
  }

  loginNow() async{
    showDialog(
      context: context,
      builder: (c){
        return LoadingDialog(
          message: "Checking Credentials",
        );
      }
    );

    User? currentUser;
    try {
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    });
    }  on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
         }
      );
    };

    // if(currentUser != null){
    //   readDataAndSetDataLocally(currentUser!).then((value){
    //     Navigator.pop(context);
    //     Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
    //   });
    // }
    if(currentUser != null){ //After successful login send rider to the home screen
      readDataAndSetDataLocally(currentUser!);//.then((value){
      //readDataAndSetDataLocally(currentUser!).then((value){
        //Navigator.pop(context);
        //Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen())); min 45 (vid 22-26)
      //});
    }
  }
  
  // Future readDataAndSetDataLocally(User currentUser) async{
  //   await FirebaseFirestore.instance.collection("sellers") //add firebase cloud package
  //     .doc(currentUser.uid)
  //     .get()
  //     .then((snapshot) async {
  //       await sharedPreferences!.setString("uid", currentUser.uid);
  //       await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
  //       await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
  //       await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
  //     });
  // }

  Future readDataAndSetDataLocally(User currentUser) async{
    await FirebaseFirestore.instance.collection("sellers") //checking if the user that is login is the riders collection //add firebase cloud package
      .doc(currentUser.uid)
      .get()
      .then((snapshot) async {
        if(snapshot.exists)
        {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
          await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        }
        else
        {
          firebaseAuth.signOut();
          sharedPreferences!.clear(); //added this, once you logout, sharedpreferences or cache data will be deleted
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
          showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "User not identified"
              );
            }
          );
        }
      });
  }
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
          const SizedBox(height: 30,),
          ElevatedButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: (){
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
```

Test 13.1: Compiled @ the branch of [`ver-1.3`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.3)

<p align="center">
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.3/sources/step13-test-1-1.jpeg" width="200">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.3/sources/step13-test-1-2.png" width="195">     <br><br>
  <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.3/sources/step13-test-1-3.png" width="700">
</p>

## 14. Add drawer
- In widgets/my_drawer.dart
  ```dart
  import 'package:flutter/material.dart';
  import 'package:foodie/authentication/auth_screen.dart';
  import 'package:foodie/global/global.dart';

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

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.monetization_on, color: Colors.red,),
                    title: const Text(
                      "My Earnings",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                      
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.reorder, color: Colors.red,),
                    title: const Text(
                      "New Orders",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                      
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_shipping, color: Colors.red,),
                    title: const Text(
                      "History - Orders",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: (){
                      
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
  ```
  <!--
  Test 14.1: Compiled @ the branch of [`ver-1.4`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.4)
  <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step14-test-1.jpeg" width="200">
  </p>
  -->

## 15 Add the menus to the seller's dashboard
- Ceate lib/uploadScreen/menus_upload_screen.dart <br/>
Allow sellers to upload images from their camera or the gallery with the functions:
`captureImageWithCamera` and `pickImageFromGallery` <br/>
Add the progress_bar.dart to display a loading icon (linear or circular)
  ```dart
  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:foodie/global/global.dart';
  import 'package:foodie/mainScreens/home_screen.dart';
  import 'package:foodie/widgets/error_dialog.dart';
  import 'package:foodie/widgets/progress_bar.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_storage/firebase_storage.dart' as storageRef;

  class MenusUploadScreen extends StatefulWidget {
    const MenusUploadScreen({Key? key}) : super(key: key);

    @override
    _MenusUploadScreenState createState() => _MenusUploadScreenState();
  }

  class _MenusUploadScreenState extends State<MenusUploadScreen> {

    XFile? imageXFile; //package image_picker
    final ImagePicker _picker = ImagePicker();
    TextEditingController shortInfoController = TextEditingController();
    TextEditingController titleController = TextEditingController();

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
            "Add New Menu",
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
                    "Add New Menu",
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
            title: const Text("Menu Image", style: TextStyle(color: Colors.red, fontWeight:FontWeight.bold),),
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
    
    menusUploadFormScreen(){
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
            "Uploading New Menu",
            style: TextStyle(fontSize: 25, fontFamily: "Lobster"),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,),
            onPressed: (){
              //Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));          
              clearMenusUploadForm();
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
                    hintText: "Menu title",
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
                    hintText: "Menu info",
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

    clearMenusUploadForm(){
      setState((){
        shortInfoController.clear();
        titleController.clear();
        imageXFile = null;
      });
    }

    validateUploadForm() async{
      if(imageXFile != null){
        if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty){
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
                message: "Please write a title and information for the menu",
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
              message: "Please pick an image for the menu"
            );
          }
        );

      }


    }

    saveInfo(String downloadUrl){
      final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");
      
      ref.doc(uniqueIdName).set({
        "menuID": uniqueIdName,
        "sellerUID": sharedPreferences!.getString(""),
        "menuInfo": shortInfoController.text.toString(),
        "menuTitle": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
      });

      clearMenusUploadForm();
      setState((){
        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    }
    uploadImage(mImageFile) async{
      storageRef.Reference reference = storageRef.FirebaseStorage
        .instance
        .ref()
        .child("menus");
      storageRef.UploadTask uploadTask = reference.child(uniqueIdName + ".jpg").putFile(mImageFile);
      storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    }
    @override
    Widget build(BuildContext context) {
      return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
    }
  }
  ```
  Test 15.1: Compiled @ the branch of [`ver-1.4`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.4)

  <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step15-test-1.jpeg" width="130"> &nbsp;
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step15-test-2.jpeg" width="130"> &nbsp;
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step15-test-3.jpeg" width="130"> &nbsp;
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step15-test-4.jpeg" width="130"> &nbsp;
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step15-test-5.jpeg" width="130"> &nbsp; <br/>
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step15-test-6.jpeg" width="600">
  </p>

## 16. Add the menus of the seller in the dashboard (home_screen)
  - Create the class menus and assign the variables that will hold the parameters of the database later
  <br/> Create the model/menus.dart
  ```dart
  import 'package:cloud_firestore/cloud_firestore.dart';

  class Menus{
    String? menuID;
    String? sellerUID;
    String? menuTitle;
    String? menuInfo;
    Timestamp? publishedDate;
    String? thumbnailUrl;
    String? status;

    Menus({
      this.menuID,
      this.sellerUID,
      this.menuTitle,
      this.menuInfo,
      this.publishedDate,
      this.thumbnailUrl,
      this.status,
    });

    Menus.fromJson(Map<String, dynamic> json){
      menuID = json["menuID"];
      sellerUID = json["sellerUID"];
      menuTitle = json["menuTitle"];
      menuInfo = json["menuInfo"];
      publishedDate = json["publishedDate"];
      thumbnailUrl = json["thumbnailUrl"];
      status = json["status"];
    }

    Map<String, dynamic> toJson(){
      final Map<String, dynamic> data = Map<String, dynamic>();
      data["menuID"] = menuID;
      data["sellerUID"] = sellerUID;
      data["menuTitle"] = menuTitle;
      data["menuInfo"] = menuInfo;
      data["publishedDate"] = publishedDate;
      data["thumbnailUrl"] = thumbnailUrl;
      data["status"] = status;

      return data;
    }
  }
  ```

- Create the info_design.dart widget that will render the database info. Add the widget to the home_scree.dart. Add also the dependency `flutter_staggered.grid.view: ^0.4.1` in the pubspec.yaml
  ```dart
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
  ```
- Create a text_widget_header.dart to easy use of text header
  ```dart
  import 'package:flutter/material.dart';

  class TextWidgetHeader extends SliverPersistentHeaderDelegate{

    String? title;
    TextWidgetHeader({this.title});

    @override
    Widget build(BuildContext context, double shrinkOffset, bool overlapsContent,){
      return InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.grey, //Colors.pink.shade400,
            //     Colors.white,
            //   ],
            //   begin: FractionalOffset(0.0, 0.0),
            //   end: FractionalOffset(1.0, 0.0),
            //   stops: [0.0, 1.0],
            //   tileMode: TileMode.clamp,
            // )
          ),
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: InkWell(
            child: Text(
              title!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Signatra",
                fontSize: 30,
                letterSpacing: 2,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
    }
    @override
    // TODO: implement maxExtent
    double get maxExtent => 50;

    @override
    double get minExtent => 50;

    @override
    bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
  }
  ```

  Test 16.1 Create a couple of menus for a user to see how it is displayed (Compiled @ the branch of [`ver-1.4`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.4)) 

  <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step16-test-1.jpeg" width="200">
  </p>

## 17. Create a widget to upload items for each menu
- Create the uploadScreens/items_upload_screen.dart file. The code inserts data to `itemsScreen.dart` and then the latter sends data to the `info_design.dart` which then is added to the `home_scrre.dart`.<br/>
`itemsUploadScreen` > `itemsScreen` > `infoDesign` > `home_screen`
  ```dart
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
  ```
- Create the mainScreens/itemsScreen.dart that will show the items 
  ```dart
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
  ```
  Test 17.1: Compiled @ the branch of [`ver-1.4`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.4)

    <p align="center">
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-1.jpeg" width="100"> &nbsp;
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-2.jpeg" width="100"> &nbsp;
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-3.jpeg" width="100"> &nbsp;
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-4.jpeg" width="100"> &nbsp;
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-5.jpeg" width="100"> &nbsp;
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-6.jpeg" width="100"> &nbsp; <br/>
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step17-test-7.jpeg" width="600">
    </p>

## 18. Display the items
- Workflow:
  - 18.1 Create the seller item: model/items.dart
  - 18.2 Create the widget: widngets/items_design.dart 
  - 18.3 Crete the Screen to display the items: mainScreens/itemsScreen.dart

  Editing the model/items.dart file
  ```dart
  import 'package:cloud_firestore/cloud_firestore.dart';

  class Items{
    String? menuID;
    String? sellerUID;
    String? itemID;
    String? title;
    String? shortInfo;
    Timestamp? publishedDate;
    String? thumbnailUrl;
    String? longDescription;
    String? status;
    int? price;

    Items({
      this.menuID,
      this.sellerUID,
      this.itemID,
      this.title,
      this.shortInfo,
      this.publishedDate,
      this.thumbnailUrl,
      this.longDescription,
      this.status,
    });

    Items.fromJson(Map<String, dynamic> json){
      menuID = json['menuID'];
      sellerUID = json['sellerUID'];
      itemID = json['itemID'];
      title = json['title'];
      shortInfo  = json['shortInfo'];
      publishedDate  = json['publishedDate'];
      thumbnailUrl  = json['thumbnailUrl'];
      longDescription  = json['longDescription'];
      status  = json['status'];
      price = json['price'];
    }

    Map<String, dynamic> toJson(){
      final Map<String, dynamic> data = Map<String, dynamic>();
      data['menuID'] = menuID;
      data['sellerUID'] = sellerUID;
      data['itemID'] = itemID;
      data['title'] = title;
      data['shortInfo'] = shortInfo;
      data['price'] = price;
      data['publishedDate'] = publishedDate;
      data['thumbnailUrl'] = thumbnailUrl;
      data['longDescription'] = longDescription;
      data['status'] = status;

      return data;
    }
  }
  ```
  Editing the widngets/items_design.dart 
  ```dart
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
  ````

  Editing the mainScreens/itemsScreen.dart
  ```dart
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
  ```
  Test 18.1: Compiled @ the branch of [`ver-1.4`](https://github.com/jatolentino/Flutter-Foodie/tree/v1.4)

  <p align="center">
    <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.4/sources/step18-test-1.jpeg" width="600">
  </p>

## 19. Touchups

- Adding a delete menu button to delete the whole menu with its items along
  <p align="center">
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-1.jpeg" width="300">
    </p>
- Adding a delete button in the item's detail screen
  <p align="center">
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-2.jpeg" width="300">
    </p>
- Completing the drawer
  - Adding the earnings screen
    <p align="center">
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-3.jpeg" width="500">
    </p>
  - Displaying the incoming orders
  
    <p align="center">
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-4.jpeg" width="500">
    </p>

  - Summary of orders with a History screen
    <p align="center">
      <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.5/sources/step19-test-5.jpeg" width="500">
    </p>
