import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/screens/common/profile/profile_screen.dart';

import '../../../../widgets/dashboard_card.dart';
import 'custom_menu.dart';
import 'parent_home_controller.dart';

class ParentHomeScreen extends GetView<ParentHomeController> {
  @override
  final controller = Get.put(ParentHomeController());

  ParentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        actions: [
          controller.profileImage.isEmpty
              ? const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/icon/logo.png',
                  ),
                )
              : Obx(
                  () => CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        controller.profileImage.value),
                  ),
                ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                          'BankIt', controller.bankItValue.toString()),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Obx(
                    () => Expanded(
                      child: DashboardCard(
                        'DMT Balance',
                        controller.parentValue.string,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Expanded(
                        child: DashboardCard(
                            'Distributor', controller.distributorValue.string,
                            onTab: () => controller.showDistributorList()),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Obx(
                      () => Expanded(
                        child: DashboardCard(
                            'Retailer', controller.retailerValue.string,
                            onTab: () => controller.showRetailerList()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Expanded(
                      child: DashboardCard(
                          'Financier', controller.financierValue.string,
                          onTab: () => controller.showFinancierList()),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Obx(
                    () => Expanded(
                      child: DashboardCard(
                        'PaySprint Balance',
                        controller.paySprint.string,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text("COMMISION DETAILS",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Expanded(
                      child: DashboardCard(
                          'My Commision', controller.ourCommision.string),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Obx(
                    () => Expanded(
                      child: DashboardCard(
                        'Distributor',
                        controller.distCommision.string,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: DashboardCard(
                        'Retailer',
                        controller.retailerCommision.string,
                      ),
                    ),
                  ),
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
                  CustomMenu(
                    controller,
                    isUser: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Create User",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomMenu(controller, isUser: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
