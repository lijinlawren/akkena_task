import 'dart:convert';

import 'package:akkena_task/home1.dart';
import 'package:akkena_task/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'config_data.dart';
import 'package:http/http.dart' as http;

class LoginPg extends StatefulWidget {
  const LoginPg({super.key});

  @override
  State<LoginPg> createState() => _LoginPgState();
}

class _LoginPgState extends State<LoginPg> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future<void> Login() async{
    final url = Uri.parse('${MyConfigs.hostIP}akkenna_login.php');
    final response = await http.post(url, body: {
      'email': email.text,
      'password': password.text
    });
    if(response.statusCode == 200){
      if(response.body.toString() == '[]'){
        Fluttertoast.showToast(
          msg: 'Login failed',
        );
      }else{
        var jsonData = json.decode(response.body);
        var jsonObt = jsonData[0];
        if(jsonObt['email'] != ''){

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home1()));
        }
      }
    }else{
      Fluttertoast.showToast(
        msg: 'Login success',
      );
    }
  }

  bool eyeclick = true;
  IconData ic = Icons.visibility_off_rounded;

  String wname = 'Welcome';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 400,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(wname,style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: eyeclick,
                controller: password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(icon: Icon(ic),onPressed: (){
                    setState(() {

                      if(eyeclick == true){
                        eyeclick = false;
                        ic = Icons.visibility_rounded;
                      }else{
                        eyeclick = true;
                        ic = Icons.visibility_off_rounded;
                      }

                    });

                  }
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {

                    Login();

                  });
                },
                child: Text('Login'),
              ),
              SizedBox(height: 15),
              InkWell(child: Text('Click here to Register'),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Register()));
              },),
            ],
          ),
        ),
      ),
    );
  }
}
