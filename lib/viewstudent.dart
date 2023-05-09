import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'connection.dart';

class Viewstudent extends StatefulWidget {
  const Viewstudent({super.key});

  @override
  State<Viewstudent> createState() => _ViewstudentState();
}

class _ViewstudentState extends State<Viewstudent> {
  Future<dynamic> getData() async {
    var response = await get(Uri.parse('${Con.url}profile.php'));
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Text(
                          snapshot.data![index]['name'],
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          snapshot.data![index]['username'],
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          snapshot.data![index]['email'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}
