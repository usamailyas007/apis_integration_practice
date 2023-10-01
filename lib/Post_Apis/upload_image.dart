import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageApi extends StatefulWidget {
  const UploadImageApi({Key? key}) : super(key: key);

  @override
  State<UploadImageApi> createState() => _UploadImageApiState();
}

class _UploadImageApiState extends State<UploadImageApi> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future getImage()async{
    final pickImage = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickImage != null){
      setState(() {
        image = File(pickImage.path);
      });
    } else{
      print('No Image Picked');
    }
  }

  Future<void> uploadImage() async{
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = 'Static title';
    var multiport = new http.MultipartFile('image', stream, length);
    request.files.add(multiport);
    var response = await request.send();
    if(response.statusCode == 200){
      print('Image Uploaded');
      setState(() {
        showSpinner = false;
      });

    }else{
      print('Uploaded Fialed');
      setState(() {
        showSpinner = false;
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Upload Image',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  getImage();
                },
                child: Container(
                  child: image == null ? Text('Pick Image'):
                      Container(
                        child: Image.file(
                          fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            File(image!.path).absolute),
                      )
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .06,
                  // width: MediaQuery.of(context).size.width * .7,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Upload Image',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
