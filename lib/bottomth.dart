import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/Teacher.dart';
import 'package:flutter_application_4/profile.dart';

class Bottomth extends StatefulWidget {
  const Bottomth({super.key});

  @override
  State<Bottomth> createState() => _BottomthState();
}

class _BottomthState extends State<Bottomth> {
  int index = 0;
  final page = [
    Teacher(),
    profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: page[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (nav) {
          setState(() {
            index = nav;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: "Profile",
            backgroundColor: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}
