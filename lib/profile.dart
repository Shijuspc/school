import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_4/connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    getData();
  }

  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString("reg_id");
    var data = {'id': sp};
    print(data);
    var response = await post(Uri.parse('${Con.url}profile.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);
    _nameController.text = res[0]['name'];
    _usernameController.text = res[0]['username'];
    _emailController.text = res[0]['email'];
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                ElevatedButton(
                    onPressed: () {
                      saveChanges();
                    },
                    child: Text('Save'))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void saveChanges() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString("reg_id");
    var data = {
      'id': sp,
      'name': _nameController.text,
      'username': _usernameController.text,
      'email': _emailController.text,
    };
    var response =
        await post(Uri.parse('${Con.url}updateprofile.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);
    Fluttertoast.showToast(msg: 'Profile Updated');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
