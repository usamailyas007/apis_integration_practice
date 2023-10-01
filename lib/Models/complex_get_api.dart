import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'complex_model.dart';

class ComplexGetApi extends StatefulWidget {
  const ComplexGetApi({Key? key}) : super(key: key);

  @override
  State<ComplexGetApi> createState() => _ComplexGetApiState();
}

class _ComplexGetApiState extends State<ComplexGetApi> {

  Future<ComplexModel> getApi ()async {
    final response = await http.get(Uri.parse('https://webhook.site/40af52e2-d7cf-466c-bbfd-e535b291b28b'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ComplexModel.fromJson(data);
    }else{
      return ComplexModel.fromJson(data);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complex Api'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              } else{
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.builder(
                           itemCount: snapshot.data!.data![index].images!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                             return Padding(
                               padding: const EdgeInsets.only(right: 10),
                               child: Container(
                                 height: MediaQuery.of(context).size.height * .25,
                                 width: MediaQuery.of(context).size.width * .8,
                                 decoration: BoxDecoration(
                                   image: DecorationImage(
                                     fit: BoxFit.cover,
                                       image: NetworkImage(
                                       snapshot.data!.data![index].images![position].url.toString())),
                                   borderRadius: BorderRadius.circular(20)

                                 ),
                               ),
                             );
                        },
                        ),
                      ),
                      ListTile(
                        title: Text(snapshot.data!.data![index].shop!.name.toString()),
                        subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                        ),
                      )
                    ],
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
