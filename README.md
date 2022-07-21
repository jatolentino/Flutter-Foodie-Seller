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
    flutter create --org com.app.foodie foodie
    ```

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
    	<img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.0/sources/step6-test-1%2C1.jpeg" width="250"> <br />
        <img src="https://github.com/jatolentino/Flutter-Foodie/blob/v1.0/sources/step6-test-1%2C2.png" width="250">        
    </p>
    
