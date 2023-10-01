import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginPostAPi extends StatefulWidget {
  const LoginPostAPi({Key? key}) : super(key: key);

  @override
  State<LoginPostAPi> createState() => _LoginPostAPiState();
}

class _LoginPostAPiState extends State<LoginPostAPi> {
  login (String email, pass) async{
    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email' : email,
          'password' : pass
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Successfully Login');
      }else {
        print('failed');
      }

    } catch (e){
      print(e.toString());
    }
  }

  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                login(emailController.text.toString(), passController.text.toString());
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurpleAccent
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
