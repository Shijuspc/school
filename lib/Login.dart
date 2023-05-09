import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/Reg.dart';
import 'package:flutter_application_4/bottomst.dart';
import 'package:flutter_application_4/bottomth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connection.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var username = TextEditingController();
  var password = TextEditingController();
  final key = GlobalKey<FormState>();

  Future<void> postData() async {
    var data = {
      "username": username.text,
      "password": password.text,
    };
    var response = await post(Uri.parse('${Con.url}login.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);

    if (response.statusCode == 200) {
      if (res['message'] == 'Login SuccessFully') {
        var id = res["log_id"];

        final spref = await SharedPreferences.getInstance();
        spref.setString("reg_id", id);
        if (res['type'] == 'teacher') {
          Fluttertoast.showToast(msg: 'Login Successfully Teacher');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Bottomth();
            },
          ));
        } else if (res['type'] == 'student') {
          Fluttertoast.showToast(msg: 'Login Successfully Student');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Bottomst();
            },
          ));
        }
      } else {
        Fluttertoast.showToast(msg: 'Invalid username or password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: key,
        child: ListView(children: [
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
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  postData();
                }
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reg(),
                  ));
            },
            child: Text(
              'New User? Create Account',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          )
        ]),
      ),
    );
  }
}
