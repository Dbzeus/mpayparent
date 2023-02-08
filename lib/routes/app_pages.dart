import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mpayparent/screens/distributor/distributor_main/distributor_main/main_screen.dart';
import 'package:mpayparent/screens/distributor/my_transaction/my_transaction_report.dart';
import 'package:mpayparent/screens/distributor/request_topup/request_topup_report.dart';
import 'package:mpayparent/screens/distributor/retailer_details/retailer_details_screen.dart';
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
    GetPage(
        name: AppRoutes.distributorMainScreen,
        page: () => DistributorMainScreen()),
    GetPage(
        name: AppRoutes.distributorWalletReportRequestScreen,
        page: () => DistributorWalletRequestScreen()),
    GetPage(
        name: AppRoutes.retailerDetailScreen,
        page: () => RetailerDetailsScreen()),
    GetPage(
        name: AppRoutes.balanceReportActivityScreen,
        page: () => BalanceReportScreen()),
    GetPage(
        name: AppRoutes.myTransactionReportScreen,
        page: () => MyTransactionReportScreen()),
    GetPage(
        name: AppRoutes.distributorRequestTopUpScreen,
        page: () => DistributorRequestTopupScreen()),
    GetPage(
        name: AppRoutes.retailerTopupScreen, page: () => RetailerTopupScreen()),
    GetPage(name: AppRoutes.topupReportScreen, page: () => TopupReportScreen()),
    GetPage(
        name: AppRoutes.requestTopupScreen, page: () => RequestTopupScreen()),

    //Sales
    GetPage(name: AppRoutes.salesMainScreen, page: () => SalesMainScreen()),
  ];
}
