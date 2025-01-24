import 'package:flutter/material.dart';
import 'package:flutter_application_1/brain/roomsBrain.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(214, 201, 20, 20),
        title: const Text("Dashboard"),
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // عدد الأعمدة
          crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
          mainAxisSpacing: 10, // المسافة العمودية بين العناصر
          children: List.generate(
            28, // عدد العناصر
            (index) => Roomsbrain(
              id: 'Room $index',
              name: "Room $index",
            ),
          ),
        ),
      ),
    );
  }
}
