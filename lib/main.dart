import 'package:example_apis/without_model.dart';
import 'package:flutter/material.dart';

import 'Models/complex_get_api.dart';
import 'Post_Apis/login_api.dart';
import 'Post_Apis/upload_image.dart';
import 'get_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UploadImageApi(),
    );
  }
}

