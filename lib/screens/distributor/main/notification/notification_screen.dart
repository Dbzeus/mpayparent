import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.notifications.isEmpty
                  ? const Center(child: Text('Empty Notificaion\'s'))
                  : RefreshIndicator(
                      onRefresh: () => controller.getNotificationList(),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.notifications.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            dense: true,
                            title: Text(
                              '${controller.notifications[index]['NotificationTitle']}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                                '${controller.notifications[index]['NotificationMsg']}'),
                            trailing: Text(
                              '${controller.notifications[index]['CuDate']}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
        ));
  }
}
