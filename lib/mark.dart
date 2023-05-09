import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connection.dart';

class mark extends StatefulWidget {
  const mark({Key? key}) : super(key: key);

  @override
  _markState createState() => _markState();
}

class _markState extends State<mark> {
  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString("mark_id");
    var data = {'id': sp};

    var response = await post(Uri.parse('${Con.url}mark.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text("name:"),
                      SizedBox(width: 10.0),
                      Text(snapshot.data![0]['name'])
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text("subject:"),
                      SizedBox(width: 10.0),
                      Flexible(
                        child: Text(
                          snapshot.data![0]['subject'],
                          overflow: TextOverflow.visible,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text("score:"),
                      SizedBox(width: 10.0),
                      Flexible(
                        child: Text(
                          snapshot.data![0]['score'],
                          overflow: TextOverflow.visible,
                        ),
                      )
                    ],
                  ),
                ),
              ]);
            }
          },
        ),
      ),
    );
  }
}
