import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/dashboard_card.dart';
import 'custom_menu.dart';
import 'finance_home_controller.dart';

class FIHomeScreen extends GetView<FIHomeController> {
  @override
  final controller = Get.put(FIHomeController());

  FIHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Dashboard'),
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
                        child: DashboardCard(
                            'My Balance', controller.myWalletBalance.string),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Obx(
                      () => Expanded(
                        child: DashboardCard('Distributor Balance',
                            controller.distributorTotalBalance.string,
                            onTab: () => controller.showDistributorList()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(
                  () => DashboardCard('Retailer Balance',
                      controller.retailerTotalBalance.string,
                      onTab: () => controller.showRetailersList()),
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
