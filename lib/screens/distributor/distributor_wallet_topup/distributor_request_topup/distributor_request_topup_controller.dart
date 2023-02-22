import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/utils/constant_function.dart';
import 'package:mpayparent/utils/constant_widgets.dart';
import 'package:mpayparent/utils/session.dart';

class DIRequestTopupController extends GetxController {
  TextEditingController bankController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxList bankList = [].obs;
  List tempList = [];
  RxBool isAttached = false.obs;
  RxBool isLoading = false.obs;
  int bankId = 0;
  String imagePath = "";
  int userId = -1;
  var res;

  DateTime today = DateTime.now();
  final _box = GetStorage();

  @override
  void onInit() {
    userId = _box.read(Session.userId) ?? -1;
    super.onInit();
    getBankList();
    checkDevice(userId);
  }

  getBankList() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getRetailerBankList(userId);

      if (response != null && response["Status"] == true) {
        bankList(response["ReturnData"]);
        tempList = response["ReturnData"];
      }
    }
  }

    attachImage() async {
      res = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (res != null) {
        File imageFile = File(res.path); //convert Path to File
        Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
        imagePath = base64.encode(imageBytes); //convert bytes to base64 string
        isAttached(true);
      }
    }

  dmtWalletTopup() async {
    Get.focusScope?.unfocus();
    if (bankId == 0) {
      toast("Select Bank");
    } else if (amountController.text.isEmpty) {
      toast("Enter Amount");
    } else {
      if (await isNetConnected()) {
        var mpin = await showMpinDialog();
        int mmpin = _box.read(Session.userMpin);
        if (mpin != null && mpin == mmpin) {
          isLoading(true);
          var params = {
            "RequestID": 0,
            "RequestFrom": userId,
            "RequestTo": 0,
            "RequestAmount": int.parse(amountController.text),
            "RequestStatus": 1,
            "RequestedDate": "",
            "PaymentMode": 0,
            "BankID": bankId,
            "Remarks": remarkController.text.trim(),
            "ProofImage": imagePath,
            "TopupID": 0
          };

          var topupResponse = await ApiCall().requestTopup(params);
          isLoading(false);
          if (topupResponse != null) {
            toast(topupResponse["Message"]);
            if (topupResponse['status']) {
              Get.back(result: true);
            }
          }
        } else {
          toast('Invalid MPIN');
        }
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      bankList(tempList);
    } else {
      bankList(tempList
          .where((element) => element["BankName"]
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList());
    }
  }
}
