import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/utils/custom_colors.dart';

import '../../../../utils/constant_string.dart';
import '../../../../widgets/dashboard_card.dart';
import 'custom_menu.dart';
import 'distributor_home_controller.dart';

class DistributorHomeScreen extends GetView<DistributorHomeController> {
  @override
  final controller = Get.put(DistributorHomeController());

  DistributorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
                        child: DashboardCard('My Balance',
                            controller.distributorCurrentBalance.string),
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

  _dashboardCard(String title, String value, {Function()? onTab}) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14, color: textColor, fontWeight: FontWeight.w800)),
          const SizedBox(
            height: 8,
          ),
          Text(
            "$rs $value",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 23,
              color: textColor,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}