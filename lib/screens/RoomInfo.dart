import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomInfo extends StatefulWidget {
  const RoomInfo({Key? key}) : super(key: key);

  @override
  State<RoomInfo> createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
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
    final CollectionReference usersCollection = FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('users');

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
              Navigator.of(context).pushNamed('/add-info',
                  arguments: {'name_info': roomTitle, 'id': roomId});
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading room data"));
          }

          final users = snapshot.data?.docs;

          if (users == null || users.isEmpty) {
            return const Center(child: Text("No users added yet"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return InkWell(
                onLongPress: () {
                  Navigator.of(context).pushNamed(
                    '/edit-room',
                    arguments: {
                      'id': user.id,
                      'name': user['Name'],
                      'sign': user['sign'],
                      'number': user['number'],
                      'roomId': roomId, // تمرير معرف الغرفة أيضًا
                    },
                  );
                },
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/rent-page',
                    arguments: {
                      'id': user.id,
                      'roomId': roomId, // تمرير معرف الغرفة أيضًا
                    },
                  );
                },
                child: ListTile(
                  title: Text(user['Name']),
                  subtitle:
                      Text('Sign: ${user['sign']} - Phone: ${user['number']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
