import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShowImage extends StatelessWidget {
  String imageUrl = Get.arguments["ImageUrl"];

  ShowImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var path = base64Decode(imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text("Proof Image"),
      ),
      body: SafeArea(
        child: Image.memory(path),
      ),
    );
  }
}
