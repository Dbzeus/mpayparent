import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/dashboard_card.dart';
import 'custom_menu.dart';
import 'sales_home_controller.dart';

class SalesHomeScreen extends GetView<SalesHomeController> {
  @override
  final controller = Get.put(SalesHomeController());

  SalesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Dashboard'),
        actions: [
          controller.profileImage.isEmpty
              ? const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/icon/profile.png',
                  ),
                )
              : Obx(
                  () => CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        controller.profileImage.value),
                  ),
                )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Expanded(
                        child: DashboardCard('Distributor Balance',
                            controller.distributorTotalBalance.string,
                            onTab: () => controller.showDistributorList()),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Obx(
                      () => Expanded(
                          child: DashboardCard('Retailer Balance',
                              controller.retailerTotalBalance.string,
                              onTab: () => controller.showRetailersList())),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("MENU",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomMenu(controller),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
