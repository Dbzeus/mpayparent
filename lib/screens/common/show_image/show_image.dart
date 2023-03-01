import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShowImage extends StatelessWidget {
  String imageUrl = Get.arguments["ImageUrl"] ?? "";

  ShowImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String image = imageUrl.replaceAll("/", '');
    // debugPrint("Image decoded path ${image}");
    // var path = base64Decode(image);
    // debugPrint("Image decoded path $path");

    return Scaffold(
      appBar: AppBar(
        title: Text("Proof Image"),
      ),
      body: SafeArea(
        child: Image.file(File.fromRawPath(base64Decode(imageUrl))),
      ),
    );
  }
}
