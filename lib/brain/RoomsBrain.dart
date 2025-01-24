import 'package:flutter/material.dart';

class Roomsbrain extends StatelessWidget {
  final String name;
  final String id;

  const Roomsbrain({super.key, required this.name,required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/rooms-info',
             arguments: {'name':name,'id':id}
             );
        // Define your action here
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
