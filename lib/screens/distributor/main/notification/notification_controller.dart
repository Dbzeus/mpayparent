import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../api/api_call.dart';
import '../../../../utils/constant_function.dart';
import '../../../../utils/session.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  RxList notifications = RxList();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  getNotificationList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response =
          await ApiCall().getNotificationList(_box.read(Session.userId));
      isLoading(false);
      if (response != null) {
        if (response['Status']) {
          notifications(response['ReturnData']);
        }
      }
    }
  }
}
