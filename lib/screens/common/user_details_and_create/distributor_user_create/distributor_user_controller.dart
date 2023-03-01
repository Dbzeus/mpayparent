import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/utils/constant_function.dart';
import 'package:mpayparent/utils/custom_colors.dart';
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
    /*  List<dynamic> fields = [
      firstNameController.text,
      lastNameController.text,
      mobileNoController.text,
      mailController.text,
      organisationNameController.text,
      addressController.text,
      gstController.text,
      aadharController.text,
      panController.text,
      aepsController.text,
      profileImage.value,
      bankAgreementFront.value,
      bankAgreementBack.value,
      aadharFront.value,
      aadharBack.value,
      panFront.value,
      mpayAgreementFront.value,
      mpayAgreementBack.value,
    ];

    if (fields.every((field) => field.isEmpty)) {
      toast("Enter all fields");
    }
*/
    if (firstNameController.text.isEmpty) {
      toast("First name should not be empty");
    } else if (lastNameController.text.isEmpty) {
      toast("Last name should not be empty");
    } else if (mobileNoController.text.isEmpty) {
      toast("Mobile number should not be empty");
    } else if (mailController.text.isEmpty) {
      toast("Mail Id should not be empty");
    } else if (organisationNameController.text.isEmpty) {
      toast("Organisation name should not be empty");
    } else if (addressController.text.isEmpty) {
      toast("Address should not be empty");
    } else if (gstController.text.isEmpty) {
      toast("please Enter gst number");
    } else if (aadharController.text.isEmpty) {
      toast("please Enter Aadahar number");
    } else if (panController.text.isEmpty) {
      toast("please Enter Pan number");
    } else if (aepsController.text.isEmpty) {
      toast("please Enter AEPS number");
    } else if (profileImage.isEmpty) {
      toast("please select profile Image");
    } else if (bankAgreementFront.isEmpty) {
      toast("please select BankAgreement Frontside photo");
    } else if (bankAgreementBack.isEmpty) {
      toast("please select BankAgreement Backside photo");
    } else if (aadharFront.isEmpty) {
      toast("please select Aadhar Frontside photo");
    } else if (aadharBack.isEmpty) {
      toast("please select Aadhar Backside photo");
    } else if (panFront.isEmpty) {
      toast("please select Pancard photo");
    } else if (mpayAgreementFront.isEmpty) {
      toast("please select MpayAgreement Frontside photo");
    } else if (mpayAgreementBack.isEmpty) {
      toast("please select MpayAgreement Backside photo");
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
          "ShopPhoto": shopImage.value.isEmpty
              ? null
              : await MultipartFile.fromFile(shopImage.toString()),
          "AadharBackPhoto": aadharBack.value.isURL
              ? null
              : await MultipartFile.fromFile(aadharBack.toString()),
          "AadharFrontPhoto": aadharFront.value.isURL
              ? null
              : await MultipartFile.fromFile(aadharFront.toString()),
          "PANFrontImage": panFront.value.isURL
              ? null
              : await MultipartFile.fromFile(panFront.toString()),
          "BankAgreementFrontPhoto": bankAgreementFront.value.isURL
              ? null
              : await MultipartFile.fromFile(bankAgreementFront.toString()),
          "BankAgreementBackPhoto": bankAgreementBack.value.isURL
              ? null
              : await MultipartFile.fromFile(bankAgreementBack.toString()),
          "YesYesAgreementFrontPhoto": mpayAgreementFront.value.isURL
              ? null
              : await MultipartFile.fromFile(bankAgreementFront.toString()),
          "YesYesAgreementBackPhoto": mpayAgreementBack.value.isURL
              ? null
              : await MultipartFile.fromFile(bankAgreementBack.toString()),
        });

        final userDetailsResponse = await ApiCall().insertUserReAndDi(formData);
        if (userDetailsResponse != null &&
            userDetailsResponse["Status"] &&
            userDetailsResponse["ReturnData"] != null) {
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
        titleStyle: const TextStyle(fontWeight: FontWeight.w600),
        content: Column(
          children: [
            ListTile(
              title: const Text(
                "Camera",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () async {
                res = await ImagePicker().pickImage(source: ImageSource.camera);
                Get.back(result: res?.path);
              },
              leading: const Icon(
                Icons.camera_alt,
                size: 30,
                color: primaryColor,
              ),
              dense: true,
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Gallery",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () async {
                res =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                Get.back(result: res?.path);
              },
              leading: const Icon(
                Icons.photo,
                size: 30,
                color: primaryColor,
              ),
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
