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
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;

  void login () async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      setState(() {
        print("success login");
      });
    }on FirebaseAuthException catch (error) {
      print("failed login $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(15),child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "phone number or email",
                labelText: "email"
            ),),

          SizedBox(height: 10,),

          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "password",
                labelText: "password"
            ),),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: login, child: Text("login")),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("created an account"),
              InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context) => SignUpScreen(),)),
                child: Text("  Sign up",style: TextStyle(color: Colors.blue),),
              )
          ],)
        ],
      ),),
    );
  }
}

