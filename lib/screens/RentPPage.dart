import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RentPage extends StatefulWidget {
  const RentPage({Key? key}) : super(key: key);

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  late String roomId;
  late String roomTitle;

  @override
  Widget build(BuildContext context) {
    // استقبال البيانات من الصفحة السابقة
    final routeArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    roomTitle = routeArgument?['name'] ?? 'Default Room Name';
    roomId = routeArgument?['id'] ?? '';

    // مرجع بيانات Firestore
    final CollectionReference rentsCollection = FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('rents');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(214, 201, 20, 20),
        title: Text(
          roomTitle,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              _showAddRentDialog(context, rentsCollection);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: rentsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading rent data"));
          }

          final rents = snapshot.data?.docs;

          if (rents == null || rents.isEmpty) {
            return const Center(child: Text("No rents added yet"));
          }

          return ListView.builder(
            itemCount: rents.length,
            itemBuilder: (context, index) {
              final rent = rents[index];
              return ListTile(
                title: Text('Rent: ${rent['rent']}'),
                subtitle: Text('Date: ${rent['date']}'),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddRentDialog(BuildContext context, CollectionReference rentsCollection) {
    final TextEditingController rentController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Rent"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: rentController,
                decoration: const InputDecoration(labelText: "Rent Amount"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Date (YYYY-MM-DD)"),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final rent = rentController.text;
                final date = dateController.text;

                if (rent.isNotEmpty && date.isNotEmpty) {
                  await rentsCollection.add({
                    'rent': rent,
                    'date': date,
                  });

                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
