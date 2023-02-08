import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';

import 'package:mpayparent/utils/constant_function.dart';
import 'package:mpayparent/utils/constant_widgets.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../../utils/constant_string.dart';

class RetailerTopupController extends GetxController {
  TextEditingController retailerController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxList<RetailerResponseReturnData> retailerList = RxList();
  List<RetailerResponseReturnData> tempList = [];
  RxBool isAttached = false.obs;
  RxBool isLoading = false.obs;
  int retailerId = -1;
  String imagePath = "";
  double distributorCurrentBalance = 0.0;
  int userId = -1;
  var res;

  final _box = GetStorage();

  @override
  void onInit() {
    userId = _box.read(Session.userId) ?? -1;
    super.onInit();
    getRetailerList();
    checkDevice(userId);
  }

  getRetailerList() async {
    if (await isNetConnected()) {
      RetailerDetailsResponse? retailerDetailsResponse = await ApiCall()
          .getRetailerDistributor(userId.toString(), retailerRoleId.toString(),
              "1"); //Retailer id = 6 is constant,its used for show total retailers balance,is fixed
      if (retailerDetailsResponse != null && retailerDetailsResponse.status) {
        if (retailerDetailsResponse.returnData.isNotEmpty) {
          retailerList(retailerDetailsResponse.returnData);
          tempList = retailerDetailsResponse.returnData;
          //Not included the AEPS Amount
        }
      }
    }
  }

  validateBalance(String amount) async {
    if (await isNetConnected()) {
      var distributorBalanceResponse =
          await ApiCall().getCurrentBalance(userId); //give
      if (distributorBalanceResponse != null &&
          distributorBalanceResponse["Status"]) {
        if (distributorBalanceResponse["ReturnData"].isNotEmpty) {
          distributorCurrentBalance =
              distributorBalanceResponse["ReturnData"][0]["Amount"];
          if (int.parse(amount) > distributorCurrentBalance) {
            showCustomAlertDialog(
                title: "Balance", content: "Insufficient Balance");
          } else {}
        }
      }
    }
  }

  retailerTopup() async {
    Get.focusScope?.unfocus();
    if (retailerId == 0) {
      toast("Select Retailer");
    } else if (amountController.text.isEmpty) {
      toast("Enter Amount");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        var distributorBalanceResponse =
            await ApiCall().getCurrentBalance(userId);
        isLoading(false);
        if (distributorBalanceResponse != null &&
            distributorBalanceResponse["Status"]) {
          if (distributorBalanceResponse["ReturnData"].isNotEmpty) {
            distributorCurrentBalance =
                distributorBalanceResponse["ReturnData"][0]["Amount"];
            if (int.parse(amountController.text) > distributorCurrentBalance) {
              showCustomAlertDialog(
                  title: "Insufficient Balance",
                  content:
                      "Your balance is ${distributorCurrentBalance} . Your transaction amount exceed your current balance.");
              Get.back();
            } else {
              var mpin = await showMpinDialog();
              int mmpin = _box.read(Session.userMpin); //need otp validation.
              if (mpin != null && mpin == mmpin) {
                isLoading(true);
                var params = {
                  "TransType": 6,
                  "TransFrom": userId,
                  "TransTo": retailerId,
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

      onSearchChanged(String text) {
        if (text.isEmpty) {
          retailerList(tempList);
        } else {
          retailerList(tempList
              .where((element) => element.firstName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
              .toList());
        }
      }
    }
  }
}
