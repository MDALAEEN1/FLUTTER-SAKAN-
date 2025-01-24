import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/HomePage.dart';
import 'package:flutter_application_1/screens/Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late String email = '';
  late String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      
      body:  
      
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // email textField
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                  hintText: "Enter your Email",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // pass textField
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                pass = value;
              },
              decoration: const InputDecoration(
                  hintText: "Enter your Password",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // login button
            child: TextButton(
              onPressed: () async {
                if (email.isEmpty || pass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter both email and password")),
                  );
                  return;
                }

                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: pass);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign-in successful!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 6, 40, 230))),
              child: const Text(
                "Sign in",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",style: TextStyle(color:Colors.black),),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signup(),
                          ));
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
          ),
          TextButton(
              onPressed: () async {
                if (email == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("please write your email.")));
                  return;
                }
                await _auth.sendPasswordResetEmail(email: email);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("check your email.")));
              },
              child: Text(
                "forget your password?",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}
