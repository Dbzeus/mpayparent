import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/screens/parent/model/userList.dart';
import 'package:mpayparent/utils/constant_function.dart';
import 'package:mpayparent/utils/constant_string.dart';
import 'package:mpayparent/utils/constant_widgets.dart';
import 'package:mpayparent/utils/session.dart';

class UserCreateController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  var userList;
  RxString imagePath = "".obs;
  String encodedImage = "";
  var userData = Get.arguments["userData"];
  RxBool isLoading = false.obs;
  int userId = -1;
  int roleId = -1;
  RxString title = "-1".obs;
  var res;

  final _box = GetStorage();

  @override
  void onInit() {
    if (userData != null) {
      userData as UserListReturnData;
      firstNameController.text = userData.firstName;
      lastNameController.text = userData.lastName;
      mobileNoController.text = userData.mobileNo;
      mailController.text = userData.emailID;
      remarksController.text = userData.remarks;
      imagePath(userData.profileImage);
    }
    title(Get.arguments["title"]);
    roleId = Get.arguments["roleId"];
    userId = _box.read(Session.userId) ?? -1;
    super.onInit();
    checkDevice(userId);
  }

  insertUser() async {
    if (firstNameController.text.isEmpty) {
      toast("First name should not be empty");
    } else if (lastNameController.text.isEmpty) {
      toast("Last name should not be empty");
    } else if (mobileNoController.text.isEmpty) {
      toast("Please Enter Mobile number ");
    } else if (mailController.text.isEmpty) {
      toast("Please enter mail id");
    } else if (remarksController.text.isEmpty) {
      toast("Fill the remarks filed");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        var params = {
          "UserID": userData != null ? userData.userID : 0,
          "RoleID": userData != null ? userData.roleID : roleId,
          "FirstName": firstNameController.text,
          "LastName": lastNameController.text,
          "MobileNo": mobileNoController.text,
          "RoleName": userData != null ? userData.roleName : "",
          "MPin": userData != null ? userData.mPin : 0,
          "OTP": userData != null ? userData.otp : 0,
          "EmailID": mailController.text,
          "Zone": userData != null ? userData.zone : "0",
          "Remarks": remarksController.text,
          "ProfileImage": encodedImage,
          "IsActive ": true,
          "CUID": userId,
          "CUDate": "",
        };
        final userDetailsResponse =
            await ApiCall().insertUserFinAndSale(params);
        if (userDetailsResponse != null && userDetailsResponse["Status"]) {
          userList(userDetailsResponse["ReturnData"]);
          toast("User Added Successfully");
          Get.back(result: true);
        }
        isLoading(false);
      }
    }
  }

  pickImage() async {
    res = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (res != null) {
      imagePath(res.path); // onvert Path to File
      File imageFile = File(res.path); //c
      Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
      encodedImage = base64.encode(imageBytes); //convert bytes to base64 string
    }
  }
}
