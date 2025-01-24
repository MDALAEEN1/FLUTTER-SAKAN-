import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditRoom extends StatelessWidget {
  const EditRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استقبال البيانات من الصفحة السابقة
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String id = args?['id'] ?? '';
    final String name = args?['name'] ?? '';
    final String sign = args?['sign'] ?? '';
    final String number = args?['number'] ?? '';
    final String roomId = args?['roomId'] ?? '';

    // إعداد الحقول
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController signController = TextEditingController(text: sign);
    final TextEditingController numberController = TextEditingController(text: number);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Info'),
        backgroundColor: const Color.fromARGB(214, 201, 20, 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "NAME",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),

            const Text(
              "SIGN",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: signController,
                decoration: const InputDecoration(  
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  // تحديث البيانات في Firestore
                  FirebaseFirestore.instance
                      .collection('rooms')
                      .doc(roomId)
                      .collection('users')
                      .doc(id)
                      .update({
                    'Name': nameController.text,
                    'sign': signController.text,
                    'number': numberController.text,
                  }).then((_) {
                    // العودة إلى الصفحة السابقة
                    Navigator.of(context).pop();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 82, 82),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
