import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/screens/distributor/distributor_main/distributor_home/distributor_home_screen.dart';
import 'package:upgrader/upgrader.dart';

import '../../../common/notification/notification_screen.dart';
import '../../../common/profile/profile_screen.dart';

import 'bottom_navigation_bar.dart';

class DistributorMainScreen extends StatelessWidget {
  DistributorMainScreen({Key? key}) : super(key: key);

  final pages = [
    DistributorHomeScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  RxInt selectedIndex = 0.obs;

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: false,
        showIgnore: false,
        showLater: false,
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onChange: (index) {
              _pageController.jumpToPage(index);
            }),
      ),
    );
  }
}
