import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/firebase_options.dart';
import 'package:firebase_authentication/screen/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;

  String message = "";

  void signUp () async {

    try {
      firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      setState(() {
        message = "sign up success : $message";
      });
    }on FirebaseAuthException catch (e) {
      setState(() {
        message = "Login failed: ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up"),
        leading: IconButton(onPressed: (){},
            icon: Icon(Icons.arrow_back)
        ),),
      body: Padding(padding: EdgeInsets.all(15),child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(),
          )
      ],),),
    );
  }
}

