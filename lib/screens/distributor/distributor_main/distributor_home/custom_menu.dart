import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/custom_colors.dart';
import 'distributor_home_controller.dart';

class CustomMenu extends StatelessWidget {
  var menus = [
    {
      'title': 'My Transaction',
      'iconUrl': "assets/icon/transfer_money.png",
      'onClickUrl': AppRoutes.distributorMyTransactionReportScreen
    },
    {
      'title': 'Retailer',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.distributorRetailerDetailScreen
    },
    {
      'title': 'Wallet Request',
      'iconUrl': "assets/icon/transfer_report.png",
      'onClickUrl': AppRoutes.distributorWalletReportRequestScreen
    },
    {
      'title': 'Topup',
      'iconUrl': "assets/icon/topup.png",
      'onClickUrl': AppRoutes.distributorTopupReportScreen
    },
    {
      'title': 'Request Topup',
      'iconUrl': "assets/icon/topup.png",
      'onClickUrl': AppRoutes.distributorRequestTopupReportScreen
    },
  ];

  CustomMenu(this.controller, {super.key});

  DistributorHomeController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.97,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16),
      itemCount: menus.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return _buildMenu(menus[index]['iconUrl'], menus[index]['title'],
            menus[index]['onClickUrl']);
      },
    );
  }

  _buildMenu(imagePath, title, onClickUrl) {
    return InkWell(
      onTap: () {
        Get.toNamed(onClickUrl);
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
            ],
          )),
    );
  }
}
