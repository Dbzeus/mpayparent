import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/utils/constant_function.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../../model/retailerDetailsResponse.dart';

class DistributorCreateController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController organisationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aepsController = TextEditingController();

  var userList;
  RxString profileImage = "".obs;
  RxString bankAgreementFront = "".obs;
  RxString bankAgreementBack = "".obs;
  RxString aadharFront = "".obs;
  RxString aadharBack = "".obs;
  RxString panFront = "".obs;
  RxString mpayAgreementFront = "".obs;
  RxString mpayAgreementBack = "".obs;
  RxString shopImage = "".obs;

  String encodedImage = "";
  RetailerResponseReturnData? userData = Get.arguments["userData"];
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
      organisationNameController.text = userData!.organisationName;
      addressController.text = userData!.organisationAddress;
      gstController.text = userData!.gstin;
      bankAgreementFront(userData!.bankAgreementFrontPhoto ?? "");
      bankAgreementBack(userData!.bankAgreementBackPhoto ?? "");
      aadharController.text = userData!.aadharNumber;
      aadharFront(userData!.aadharFrontPhoto ?? "");
      aadharBack(userData!.aadharBackPhoto ?? "");
      panController.text = userData!.pANNo;
      panFront(userData!.pANFrontImage);
      aepsController.text = userData!.aepsid;
      mpayAgreementFront(userData!.yesYesAgreementFrontPhoto);
      mpayAgreementBack(userData!.yesYesAgreementBackPhoto);
      profileImage(userData!.profilePhoto ?? "");
    }
    title(Get.arguments["title"]);
    roleId = Get.arguments["roleId"];
    userId = _box.read(Session.userId) ?? -1;
    super.onInit();
    checkDevice(userId);
  }

  insertUser() async {
    if (firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty &&
        mobileNoController.text.isEmpty &&
        mailController.text.isEmpty &&
        organisationNameController.text.isEmpty &&
        addressController.text.isEmpty &&
        gstController.text.isEmpty &&
        aadharController.text.isEmpty &&
        panController.text.isEmpty &&
        aepsController.text.isEmpty &&
        profileImage.value.isEmpty &&
        bankAgreementFront.isEmpty &&
        bankAgreementBack.isEmpty &&
        aadharFront.isEmpty &&
        aadharBack.isEmpty &&
        panFront.isEmpty &&
        mpayAgreementFront.isEmpty &&
        mpayAgreementBack.isEmpty &&
        shopImage.isEmpty) {
      toast("Enter all fields");
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
          "MPin": 0,
          "OTP": 0,
          "EmailID": mailController.text,
          "OrganisationName": organisationNameController.text,
          "OrganisationAddress": addressController.text,
          "GSTIN": gstController.text,
          "AadharNumber": aadharController.text,
          "PANNo": panController.text,
          "IsActive": true,
          "CUID": userId,
          "AEPSID": aepsController.text,
        };

        FormData formData = FormData.fromMap({
          "RetailerDetails": jsonEncode(params),
          "ProfilePhoto": profileImage.value.isURL
              ? null
              : await MultipartFile.fromFile(profileImage.toString()),
          "ShopPhoto": await MultipartFile.fromFile(shopImage.toString()),
          "AadharBackPhoto":
              await MultipartFile.fromFile(aadharBack.toString()),
          "AadharFrontPhoto":
              await MultipartFile.fromFile(aadharFront.toString()),
          "PANFrontImage": await MultipartFile.fromFile(panFront.toString()),
          "BankAgreementFrontPhoto":
              await MultipartFile.fromFile(bankAgreementFront.toString()),
          "BankAgreementBackPhoto":
              await MultipartFile.fromFile(bankAgreementBack.toString()),
          "YesYesAgreementFrontPhoto":
              await MultipartFile.fromFile(bankAgreementFront.toString()),
          "YesYesAgreementBackPhoto":
              await MultipartFile.fromFile(bankAgreementBack.toString()),
        });

        final userDetailsResponse = await ApiCall().insertUserReAndDi(formData);
        if (userDetailsResponse != null && userDetailsResponse["Status"]) {
          userList(userDetailsResponse["ReturnData"]);
          Get.back(result: true);
          toast("User Added Successfully");
        }
        isLoading(false);
      }
    }
  }

  pickImage() async {
    Get.focusScope?.unfocus();
    return await Get.defaultDialog(
        title: "Pick Image From",
        content: Column(
          children: [
            ListTile(
              title: const Text("Camera"),
              onTap: () async {
                res = await ImagePicker().pickImage(source: ImageSource.camera);
                Get.back(result: res?.path);
              },
              leading: const Icon(Icons.camera_alt),
              dense: true,
            ),
            const Divider(),
            ListTile(
              title: const Text("Gallery"),
              onTap: () async {
                res =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                Get.back(result: res?.path);
              },
              leading: const Icon(Icons.photo),
              dense: true,
            ),
          ],
        ));
  }

/*  pickImage() async {
    res = await ImagePicker().pickImage(source: ImageSource.gallery);
    return res?.path ?? "";
  }*/
}
