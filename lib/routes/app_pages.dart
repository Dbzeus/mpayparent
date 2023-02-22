import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mpayparent/screens/common/show_image/show_image.dart';
import 'package:mpayparent/screens/common/topup/topup.dart';
import 'package:mpayparent/screens/common/user_details_and_create/user_create/user_create.dart';
import 'package:mpayparent/screens/common/user_details_and_create/user_details/user_details_screen.dart';
import 'package:mpayparent/screens/distributor/distributor_main/distributor_main/di_main_screen.dart';
import 'package:mpayparent/screens/distributor/my_transaction/my_transaction_report.dart';
import 'package:mpayparent/screens/distributor/request_topup/di_request_topup_report.dart';
import 'package:mpayparent/screens/distributor/retailer_details/retailer_details_screen.dart';
import 'package:mpayparent/screens/finance/finance_main/finance_main/finance_main_screen.dart';
import 'package:mpayparent/screens/finance/request_topup/fi_request_topup_report.dart';
import 'package:mpayparent/screens/parent/parent_aeps_report/parent_aeps_report_screen.dart';
import 'package:mpayparent/screens/parent/parent_main/parent_main/parent_main_screen.dart';
import 'package:mpayparent/screens/parent/topup_activity/topup_activity.dart';
import 'package:mpayparent/screens/sales/sa_di_details/sa_di_details_screen.dart';

import 'package:mpayparent/screens/sales/sa_dmt_transaction_report/sa_dmt_report_screen.dart';
import 'package:mpayparent/screens/sales/sa_topup/sa_topup_report_screen.dart';
import 'package:mpayparent/screens/sales/sales_main/sales_main/sales_main_screen.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/auth/otp/otp_screen.dart';
import '../screens/common/balance_report/balance_report.dart';
import '../screens/distributor/distributor_wallet_topup/distributor_request_topup/distributor_request_topup_screen.dart';
import '../screens/distributor/distributor_wallet_topup/distributor_wallet_request/distributor_wallet_report_request.dart';
import '../screens/distributor/retailer_topup_report/retailer_topup/retailer_topup.dart';
import '../screens/distributor/retailer_topup_report/topup_report/topup_report_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.otpScreen, page: () => OtpScreen()),

    //show image common screen
    GetPage(name: AppRoutes.showImage, page: () => ShowImage()),

    //topup common screen
    GetPage(name: AppRoutes.topupScreen, page: () => TopupScreen()),

    //UserDetails common screen
    GetPage(name: AppRoutes.userDetailsScreen, page: () => UserDetailsScreen()),

    //UserCreate common screen
    GetPage(name: AppRoutes.userCreateScreen, page: () => UserCreateScreen()),

    //Balance report common screen
    GetPage(
        name: AppRoutes.balanceReportActivityScreen,
        page: () => BalanceReportScreen()),

    //distributor
    GetPage(name: AppRoutes.distributorMainScreen, page: () => DIMainScreen()),
    GetPage(
        name: AppRoutes.distributorWalletReportRequestScreen,
        page: () => DIWalletRequestScreen()),
    GetPage(
        name: AppRoutes.distributorRetailerDetailScreen,
        page: () => DIRetailerDetailsScreen()),

    GetPage(
        name: AppRoutes.distributorMyTransactionReportScreen,
        page: () => DIMyTransactionReportScreen()),
    GetPage(
        name: AppRoutes.distributorRequestTopUpScreen,
        page: () => DIRequestTopupScreen()),
    GetPage(
        name: AppRoutes.distributorRetailerTopupScreen,
        page: () => DIRetailerTopupScreen()),
    GetPage(
        name: AppRoutes.distributorTopupReportScreen,
        page: () => DITopupReportScreen()),
    GetPage(
        name: AppRoutes.distributorRequestTopupReportScreen,
        page: () => DIRequestTopupReportScreen()),

    //Sales
    GetPage(name: AppRoutes.salesMainScreen, page: () => SAMainScreen()),
    GetPage(
        name: AppRoutes.salesDistributorScreen,
        page: () => SADistributorScreen()),
    GetPage(
        name: AppRoutes.salesDMTReportScreen, page: () => SADmtReportScreen()),
    GetPage(
        name: AppRoutes.salesTopupReportScreen,
        page: () => SATopupReportScreen()),

    //finance
    GetPage(name: AppRoutes.financeMainScreen, page: () => FIMainScreen()),
    GetPage(
        name: AppRoutes.financeRequestTopupReportScreen,
        page: () => FIRequestTopupReportScreen()),

    //parent
    GetPage(name: AppRoutes.parentMainScreen, page: () => ParentMainScreen()),
    GetPage(
        name: AppRoutes.parentTopupActivityScreen,
        page: () => PATopupActivityScreen()),
    GetPage(
        name: AppRoutes.parentAEPSReportScreen,
        page: () => PAAepsReportScreen()),
  ];
}
