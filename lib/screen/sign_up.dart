import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

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
   @override
   Widget build(BuildContext context) {

     final emailController = TextEditingController();
     final passwordController = TextEditingController();

     final firebaseAuth =  FirebaseAuth.instance;

     void signUp () async{
       try {
         final userAuth = await firebaseAuth.createUserWithEmailAndPassword(
             email: emailController.text,
             password: passwordController.text
         );
         setState(() {
           print("success auth");
         });
       }catch (e) {
         setState(() {
           print("error");
         });
       }
     }

     return Scaffold(
       appBar: AppBar(title: Text("firebase Sign up"),),

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
           ElevatedButton(
             onPressed: signUp,
             child: const Text('Sign Up'),
           ),

         ],
       ),),
     );
   }
 }
