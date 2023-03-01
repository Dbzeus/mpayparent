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

class TopupController extends GetxController {
  TextEditingController payeeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxList<RetailerResponseReturnData> distributorList = RxList();
  //List<RetailerResponseReturnData> tempListDi = [];
  var userList;
  var tempList;
  String imagePath = "";
  RxList<UserListReturnData> financierList = RxList();
//  List<UserListReturnData> tempList = [];
  RxBool isAttached = false.obs;
  RxBool isLoading = false.obs;
  int payeeId = -1;
  double currentBalance = 0.0;
  int userId = -1;
  int tType = -1;
  RxString title = "-1".obs;
  RxString payeeTitle = "-1".obs;
  bool isParent = false;
  bool isFinance = false;
  var res;

  final _box = GetStorage();

  @override
  void onInit() {
    tType = Get.arguments["tType"];
    if (tType == financierTypeId) {
      title("Financier Topup");
      payeeTitle("Financier");
      getFinancierDetails();
    } else if (tType == distributorTypeId) {
      title("Distributor Topup");
      payeeTitle("Distributor");

      getDistributorDetails();
    } else if (tType == bankItTypeId) {
      title("BankIt Topup");
      isParent = true;
      payeeId = 1;
    } else {
      title("Distributor Topup");
      payeeTitle("Distributor");
      isFinance = true;
      getDistributorDetails();
    }
    userId = _box.read(Session.userId) ?? -1;
    super.onInit();
    checkDevice(userId);
  }

  getDistributorDetails() async {
    if (await isNetConnected()) {
      isLoading(true);
      RetailerDetailsResponse? distributorDetailsResponse =
          await ApiCall().getRetailerDistributor("0", "5", "1");
      if (distributorDetailsResponse != null &&
          distributorDetailsResponse.status) {
        if (distributorDetailsResponse.returnData.isNotEmpty) {
          distributorList(distributorDetailsResponse.returnData);
          //tempListDi = distributorDetailsResponse.returnData;
          userList = distributorList
              .map((element) => {
                    "name": element.firstName,
                    "no": element.mobileNo,
                    "id": element.userID
                  })
              .toList();
          tempList = userList;
        }
      }
      isLoading(false);
    }
  }

  getFinancierDetails() async {
    if (await isNetConnected()) {
      isLoading(true);
      UserList? financierDetailsResponse =
          await ApiCall().getUserDetailsByRole("0", "3", "1");
      if (financierDetailsResponse != null && financierDetailsResponse.status) {
        if (financierDetailsResponse.returnData.isNotEmpty) {
          financierList(financierDetailsResponse.returnData);
          //tempList = financierDetailsResponse.returnData;
          userList = financierList
              .map((element) => {
                    "name": element.firstName,
                    "no": element.mobileNo,
                    "id": element.userID,
                  })
              .toList();
          tempList = userList;
        }
      }
      isLoading(false);
    }
  }

  topup() async {
    Get.focusScope?.unfocus();
    if (payeeId == 0 || payeeId == -1) {
      toast("Select ${payeeTitle.value.toString()}");
    } else if (amountController.text.isEmpty) {
      toast("Enter Amount");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        var currentBalanceResponse = await ApiCall().getCurrentBalance(userId);
        isLoading(false);
        if (currentBalanceResponse != null &&
            currentBalanceResponse["Status"]) {
          if (currentBalanceResponse["ReturnData"].isNotEmpty) {
            currentBalance = currentBalanceResponse["ReturnData"][0]["Amount"];
            debugPrint(currentBalance.toString());
            if (int.parse(amountController.text) > currentBalance) {
              showCustomAlertDialog(
                  title: "Insufficient Balance",
                  content:
                      "Your balance is $currentBalance . Your transaction amount exceed your current balance.");
            } else {
              var mpin = await showMpinDialog();
              int mmpin = _box.read(Session.userMpin); //need otp validation.
              if (mpin != null && mpin == mmpin) {
                isLoading(true);
                var params = {
                  "TransType": tType,
                  "TransFrom": userId,
                  "TransTo": payeeId,
                  "UserID": userId,
                  "Amount": amountController.text,
                  "Remarks": remarkController.text.toString(),
                };
                final topupResponse =
                    await ApiCall().retailerDistributorTopup(params);
                if (topupResponse != null) {
                  toast("Amount added successfully");
                  debugPrint("Payment success");
                }
                isLoading(false);
                Get.back();
              } else {
                toast('Incorrect MPIN');
                Get.back();
              }
            }
          }
        }
      }
    }
  }

  onSearchChangedDistributor(String text) {
    if (text.isEmpty) {
      userList(tempList);
    } else {
      userList(tempList
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList());
    }
  }

  /* onSearchChangedFinancier(String text) {
    if (text.isEmpty) {
      financierList(tempList);
    } else {
      financierList(tempList
          .where((element) => element.firstName
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList());
    }
  }*/

  attachImage() async {
    res = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (res != null) {
      File imageFile = File(res.path); //convert Path to File
      Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
      imagePath = base64.encode(imageBytes); //convert bytes to base64 string
      isAttached(true);
    }
  }
}
