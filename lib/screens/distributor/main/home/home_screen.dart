import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/utils/custom_colors.dart';

import '../../../../utils/constant_string.dart';
import 'custom_menu.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("My Balance",
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            )),
                        Obx(
                          () => Text(
                              "$rs ${controller.distributorCurrentBalance.toString()}",
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.showRetailersList();
                    },
                    child: Container(
                      height: 100,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Retailer Balance",
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(
                            () => Text(
                                "$rs ${controller.retailerTotalBalance.toString()}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("View Details",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                  )),
                              Icon(
                                Icons.arrow_circle_right_rounded,
                                color: textColor,
                                size: 16,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //CustomWalletCard(),
              /*Container(
                width: Get.width,
                height: Get.height * 0.25,
                color: primaryColor,
                padding: const EdgeInsets.only(left: 16, right: 12, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/icon/mpayy.png',
                          width: 120,
                          color: Colors.white,
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/icon/p.png',
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    const Text("Active DMT balance",
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                              "$rs ${controller.dmtBalance.value.toString()}",
                              style: const TextStyle(
                                fontSize: 28,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        CustomButton(
                          width: 100,
                          height: 30,
                          text: "ADD +",
                          onTap: () {
                            Get.toNamed(AppRoutes.dmtTopup);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),*/
              RefreshIndicator(
                onRefresh: () => controller.onRefresh(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 24, right: 12),
                    child: Column(
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
                  ),
                ),
              ),
            ],
          ),
          Obx(() => controller.isLoading.value
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
