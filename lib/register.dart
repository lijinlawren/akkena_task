import 'dart:convert';

import 'package:akkena_task/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'config_data.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController phone_number = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future<void> Resigter() async{
    Fluttertoast.showToast(msg: 'Please wait!');
    final url = Uri.parse('${MyConfigs.hostIP}akkenna.register.php');
    final response = await http.post(url, body: {
      'email': email.text,
      'password': password.text,
      'phone_nuber': phone_number.text,
      'name': name.text,
    });
    if(response.statusCode == 200){
      Fluttertoast.showToast(msg: 'Registration success');
      if(response.body.toString() == '[]'){
        Fluttertoast.showToast(
          msg: 'Login failed',
        );
      }else{
        var jsonData = json.decode(response.body);
        var jsonObt = jsonData[0];
        if(jsonObt['email'] != ''){

          print(jsonObt['admin_user_id']);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPg()));
        }
      }
    }else{
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 400,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text('Enter all the field',style: TextStyle(fontSize: 20)),
              SizedBox(height: 10,),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: phone_number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwords',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if(name.text.isEmpty || phone_number.text.isEmpty || password.text.isEmpty || email.text.isEmpty){
                    Fluttertoast.showToast(msg: 'Please fill the required field');
                  }else(
                      Resigter()
                  );


                },
                //
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
