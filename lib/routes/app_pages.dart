import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mpayparent/screens/balance_report_activity/balance_report_activity.dart';
import 'package:mpayparent/screens/distributor/retailer_details/retailer_details_screen.dart';
import '../reports/my_transaction/my_transaction_report.dart';
import '../screens/distributor/main/main/main_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/otp/otp_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.otpScreen, page: () => OtpScreen()),
    GetPage(name: AppRoutes.mainScreen, page: () => MainScreen()),
    GetPage(
        name: AppRoutes.retailerDetailScreen,
        page: () => RetailerDetailsScreen()),
    GetPage(
        name: AppRoutes.balanceReportActivityScreen,
        page: () => BalanceReportActivityScreen()),
    GetPage(
        name: AppRoutes.myTransactionReportScreen,
        page: () => MyTransactionReportScreen())
    /*GetPage(name: AppRoutes.mainScreen, page: () => MainScreen()),
    GetPage(name: AppRoutes.otpScreen, page: () => OtpScreen()),
    GetPage(name: AppRoutes.dmtTopup, page: () => DmtTopupScreen()),
    GetPage(name: AppRoutes.dmtReport, page: () => DmtReportScreen()),
    GetPage(name: AppRoutes.topupReport, page: () => TopupReportScreen()),
    GetPage(name: AppRoutes.dmtTransaction, page: () => DMTTransaction()),
    GetPage(
        name: AppRoutes.transactionDetail,
        page: () => TransactionDetailScreen()),
    GetPage(
      name: AppRoutes.paymentStatus,
      page: () => PaymentStatusScreen(),*/
  ];
}
