import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // State variables for form fields
  String Name = "";
  String surname = "";
  String Number = "";
  String tax = "";

  // TextEditingControllers for managing input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController signController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController taxController = TextEditingController();

  // Function to validate phone number
  bool isPhoneNumberValid(String number) {
    final phoneRegExp = RegExp(r'^\d+$');
    return phoneRegExp.hasMatch(number);
  }

  // Function to add a user to Firestore
  Future<void> addUser(String roomId) async {
    if (Name.isEmpty || surname.isEmpty || Number.isEmpty || tax.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    if (!isPhoneNumberValid(Number)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid phone number!")),
      );
      return;
    }

    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('users');

      await usersCollection.add({
        "Name": Name,
        "sign": surname,
        "number": Number,
        "tax": tax,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User added successfully!")),
      );

      // Clear input fields
      nameController.clear();
      signController.clear();
      numberController.clear();
      taxController.clear();
      setState(() {
        Name = "";
        surname = "";
        Number = "";
        tax = "";
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add user: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve room information from arguments
    final routeArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final RoomTitle = routeArgument?['name_info'] ?? 'Default Room Name';
    final roomId = routeArgument?['id'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Add person in $RoomTitle'),
        backgroundColor: const Color.fromARGB(214, 201, 20, 20),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "NAME",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    Name = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Add name here",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const Text(
              "surname",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: signController,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    surname = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Add sign here",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const Text(
              "PHONE NUMBER",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    Number = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Add phone number here",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const Text(
              "RENT",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taxController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    tax = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Add tax here",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: ElevatedButton(
                onPressed: () => addUser(roomId), // Pass roomId to addUser
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 82, 82, 1),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "ADD",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
