import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/Login.dart';
import 'package:flutter_application_4/connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  var name = TextEditingController();
  var username = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  final key = GlobalKey<FormState>();
  Future<void> postData() async {
    var data = {
      "name": name.text,
      "username": username.text,
      "email": email.text,
      "password": password.text,
    };
    var resp = await post(Uri.parse('${Con.url}Reg.php'), body: data);
    var res = jsonDecode(resp.body);
    print(res);
    if (resp.statusCode == 200) {
      if (res['message'] == 'Register SuccsessFully') {
        Fluttertoast.showToast(msg: 'Register Succesfully');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ));
      } else {
        Fluttertoast.showToast(msg: 'Already you have account');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: key,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your Name";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: username,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your Username";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your Email";
                }
                if (!value.contains("@")) {
                  return "Enter Valid Email";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: password,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your Password";
                } else if (value.length < 4) {
                  return "atleast 4 characters";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (key.currentState!.validate()) {
                postData();
              }
            },
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
            },
            child: Text(
              'Already you have account',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ]),
      ),
    );
  }
}
