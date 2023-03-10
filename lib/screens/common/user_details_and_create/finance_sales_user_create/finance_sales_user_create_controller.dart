import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/screens/parent/model/userList.dart';
import 'package:mpayparent/utils/constant_function.dart';
import 'package:mpayparent/utils/session.dart';

class FinanceSalesCreateController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  var userList;
  RxString imagePath = "".obs;
  UserListReturnData? userData = Get.arguments["userData"];
  RxBool isLoading = false.obs;
  int userId = -1;
  int roleId = -1;
  RxString title = "-1".obs;
  var res;

  final _box = GetStorage();

  @override
  void onInit() {
    if (userData != null) {
      firstNameController.text = userData!.firstName;
      lastNameController.text = userData!.lastName;
      mobileNoController.text = userData!.mobileNo;
      mailController.text = userData!.emailID;
      remarksController.text = userData!.remarks;
      zoneController.text = userData!.zone;
      imagePath(userData!.profileImage ?? "");
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
          "UserID": userData?.userID ?? 0,
          "RoleID": userData?.roleID ?? roleId,
          "FirstName": firstNameController.text,
          "LastName": lastNameController.text,
          "MobileNo": mobileNoController.text,
          "RoleName": userData?.roleName ?? "",
          "MPin": userData!.mPin ?? 0, // need to clarify mpin andd otp
          "OTP": userData!.otp ?? 0,
          "EmailID": mailController.text,
          "Zone": zoneController.text,
          "Remarks": remarksController.text,
          "ProfileImage": imagePath,
          "IsActive ": true,
          "CUID": userData?.isActive ?? true,
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

    return res.path;
  }
}
