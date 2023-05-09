import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/Student.dart';
import 'package:flutter_application_4/profile.dart';

class Bottomst extends StatefulWidget {
  const Bottomst({super.key});

  @override
  State<Bottomst> createState() => _BottomstState();
}

class _BottomstState extends State<Bottomst> {
  int index = 0;
  final page = [
    Student(),
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
