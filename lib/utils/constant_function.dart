import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../api/api_call.dart';
import '../routes/app_routes.dart';
import 'constant_widgets.dart';

// var deviceInfo = DeviceInfoPlugin();
var connectivity = Connectivity();

isNetConnected() async {
  var result = await connectivity.checkConnectivity();
  bool res = result != ConnectivityResult.none;
  if (!res) {
    toast(
      "Check Your Internet Connection",
    );
  }
  return res;
}

toast(String? msg) {
  debugPrint(msg ?? "Something went wrong");
  Fluttertoast.showToast(
    gravity: ToastGravity.CENTER,
    backgroundColor: secondaryColor,
    msg: msg ?? "Something went wrong",
  );
}

Future<String> getId() async {
  return await PlatformDeviceId.getDeviceId ?? "";
  // if (Platform.isIOS) {
  //   var iosDeviceInfo = await deviceInfo.iosInfo;
  //   return iosDeviceInfo.identifierForVendor ??
  //       'UNIDENTIFIED'; // unique ID on iOS
  // } else if (Platform.isAndroid) {
  //   var androidDeviceInfo = await deviceInfo.androidInfo;
  //   debugPrint(androidDeviceInfo.id);
  //   return androidDeviceInfo.id ?? 'UNIDENTIFIED'; // unique ID on Android
  // } else {
  //   return 'UNIDENTIFIED';
  // }
}

getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

maskedOutput(String str, {int unmaskedLength = 3, String maskedChar = '*'}) {
  return str.replaceRange(0, str.length - unmaskedLength,
      maskedChar * (str.length - unmaskedLength));
}

checkDevice(int userId) async {
  var deviceCheckResponse = await ApiCall().checkDevice(
      userId, await getId()); //checking the Multiple login in mobile device
  if (deviceCheckResponse != null && !deviceCheckResponse["Status"]) {
    showCustomAlertDialog(
      title: 'Verify Its You!',
      content:
          'This device doesn\'t match your credential, Please logout and re-login or contact admin',
      confirm: 'Logout',
      onTabConfirm: () {
        final box = GetStorage();
        box.erase();
        Get.offAllNamed(AppRoutes.loginScreen);
      },
      isDismissable: true,
    );
  }
}
