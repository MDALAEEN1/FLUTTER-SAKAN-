import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/Signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  late String email = '';
  late String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email textField
            TextField(
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
            const SizedBox(height: 10),
            // Password textField
            TextField(
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
            const SizedBox(height: 15),
            // Sign-up button
            TextButton(
              onPressed: () async {
                if (email.isEmpty || pass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter both email and password")),
                  );
                  return;
                }

                try {
                  await _auth.createUserWithEmailAndPassword(
                      email: email, password: pass);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sign-up successful!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 231, 153, 8))),
                      
              child: const Text(
                "Sign up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Row for login and password recovery
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do you have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: Color.fromARGB(255, 231, 153, 8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
