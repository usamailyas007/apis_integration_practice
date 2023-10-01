import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutModelApis extends StatefulWidget {
  const WithoutModelApis({Key? key}) : super(key: key);

  @override
  State<WithoutModelApis> createState() => _WithoutModelApisState();
}

class _WithoutModelApisState extends State<WithoutModelApis> {
  var data;
  Future<void> getApis () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Apis'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApis(),
              builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting ){
                return Center(child: CircularProgressIndicator());
              }else{
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        CustomRow(
                          text: 'Name',
                          text1: data[index]['name'].toString(),
                        ),
                        CustomRow(
                          text: 'UserName',
                          text1: data[index]['username'].toString(),
                        ),
                        CustomRow(
                          text: 'Address',
                          text1: data[index]['address']['city'].toString(),
                        ),
                        CustomRow(
                          text: 'Geo',
                          text1: data[index]['address']['geo']['lat'].toString(),
                        ),
                      ],
                    ),
                  );
                },);
              }
            },),
          )
        ],
      ),
    );
  }
}


class CustomRow extends StatelessWidget {
  String text;
  String text1;
  CustomRow({Key? key,required this.text,required this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Text(text1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
        ],
      ),
    );
  }
}
