import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Tables extends StatefulWidget {
  const Tables({super.key});

  @override
  State<Tables> createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Table(
              border: TableBorder.all(
                  width: 1, color: Colors.black45), //table border
              children: [
                TableRow(children: [
                  TableCell(child: Text("subject")),
                  TableCell(child: Text("Monday")),
                  TableCell(child: Text("Tuesday")),
                  TableCell(child: Text("Wendesday")),
                  TableCell(child: Text("Thursday")),
                  TableCell(child: Text("Friday")),
                ]),
                TableRow(children: [
                  TableCell(child: Text("English")),
                  TableCell(child: Text("12.00 PM")),
                  TableCell(child: Text("10.00 AM")),
                  TableCell(child: Text("1.00 PM")),
                  TableCell(child: Text("2.00 PM")),
                  TableCell(child: Text("4.00 PM")),
                ]),
                TableRow(children: [
                  TableCell(child: Text("physics")),
                  TableCell(child: Text("12.00 PM")),
                  TableCell(child: Text("10.00 AM")),
                  TableCell(child: Text("1.00 PM")),
                  TableCell(child: Text("2.00 PM")),
                  TableCell(child: Text("4.00 PM")),
                ]),
                TableRow(children: [
                  TableCell(child: Text("Maths")),
                  TableCell(child: Text("12.00 PM")),
                  TableCell(child: Text("10.00 AM")),
                  TableCell(child: Text("1.00 PM")),
                  TableCell(child: Text("2.00 PM")),
                  TableCell(child: Text("4.00 PM")),
                ]),
              ],
            )));
  }
}
