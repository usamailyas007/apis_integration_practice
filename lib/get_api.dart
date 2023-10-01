import 'dart:convert';

import 'package:flutter/material.dart';
import 'Models/commentModel.dart';
import 'Models/photosModel.dart';
import 'Models/postsModel.dart';
import 'package:http/http.dart' as http;

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  //Get Api by using Custom Model

  final List<customPhotosModel> photosList = [];
  Future<List<customPhotosModel>> getPhotosApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    print(data);
    if(response.statusCode == 200){
      for(Map i in data){
        customPhotosModel photos = customPhotosModel(id: i['id'], title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    }else {
      return photosList;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Posts Apis',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),
              builder: (context,AsyncSnapshot<List<customPhotosModel>> snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              } else{
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString(),
                        ),),
                      title: Text('Id: '+snapshot.data![index].id.toString()),
                      subtitle: Text(snapshot.data![index].title.toString()),
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



class customPhotosModel{
  String title;
  int id;
  String url;
  customPhotosModel({
   required this.id,required this.title,required this.url
});
}