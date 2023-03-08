import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mpayparent/model/distributorRequestResponse.dart';
import 'package:mpayparent/model/myTransactionResponse.dart';
import 'package:mpayparent/model/parentDashboardResponse.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/model/retailerTopupHistoryResponse.dart';
import 'package:mpayparent/screens/parent/model/userList.dart';

import '../main.dart';
import '../model/balance_report_response.dart';
import '../model/dmt_report_response.dart';
import '../utils/constant_function.dart';
import 'url.dart';

class ApiCall {
  static final Dio _dio = Dio();
  static final ApiCall _instance = ApiCall._internal();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  //Login
  Future<dynamic> checkLogin(String mobileNo, String mpin, String token) async {
    try {
      var params = {"MPIN": mpin, "mobileno": mobileNo, "MobileToken": token};

      log(jsonEncode(params));

      final response = await _dio.post(loginUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //deviceCheck
  checkDevice(int userId, String deviceId) async {
    try {
      var params = {
        "UserID": userId,
        "DeviceID": deviceId,
        "DeviceType": 1,
      };

      final response = await _dio.get(checkDeviceUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //Otp Verfication
  Future<dynamic> otpVerification(String mobileNo, String otp) async {
    try {
      var params = {
        "mobileno": mobileNo,
        "OTP": otp,
      };

      log(jsonEncode(params));

      final response = await _dio.post(otpVerficationUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //ReSend Otp
  Future<dynamic> resendOTP(String mobileNo, String token) async {
    try {
      var params = {"appusermobileno": mobileNo, "MobileToken": token};

      log(jsonEncode(params));

      final response = await _dio.post(resendOTPUrl, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //Logout device
  Future<dynamic> logoutDevice(String userId, String deviceType) async {
    try {
      var params = {
        "UserID": userId,
        "DeviceType": deviceType,
      };

      log(jsonEncode(params));

      final response = await _dio.get(logoutUrl, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //notification
  getNotificationList(int userId) async {
    try {
      final response =
          await _dio.get(notificationUrl, queryParameters: {'UserID': userId});
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //Get balance
  Future<BalanceReportResponse?> getBalance(int userId, int roleId) async {
    try {
      var params = {"ParentID": userId, "RoleID": roleId};
      final response =
          await _dio.get(retailerBalanceUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return BalanceReportResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //Parent Dashboard
  Future<ParentDashboardResponse?> parentDashboard() async {
    try {
      final response = await _dio.get(
        parentDashboardUrl,
      );
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return ParentDashboardResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //Get current balance for user
  getCurrentBalance(int userId) async {
    try {
      var params = {
        "UserID": userId,
      };
      final response =
          await _dio.get(mywalletBalanceUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //get MyTransactipnReport
  Future<MyTransactionResponse?> getMyTranactionReport(
      int userId, String fromDate, String toDate) async {
    try {
      var params = {
        "UserID": userId,
        "StartDate": fromDate,
        "EndDate": toDate,
      };

      final response =
          await _dio.get(myTransactionUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return MyTransactionResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //get Retailer details
  Future<RetailerDetailsResponse?> getRetailerDistributor(
      String userId, String roleId, String showAll) async {
    try {
      var params = {"UserID": userId, "RoleID": roleId, "ShowAll": showAll};
      final response =
          await _dio.get(retailerDistributorUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return RetailerDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //Request Topup
  Future<dynamic> requestTopup(var params) async {
    try {
      log(jsonEncode(params));

      final response = await _dio.post(distributorTopupUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //get user bank details
  getRetailerBankList(int userId) async {
    try {
      final response = await _dio
          .get(userBankDetailsUrl, queryParameters: {'UserID': userId});
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //distributor topup the account for retailer
  Future<dynamic> retailerDistributorTopup(var params) async {
    try {
      log(jsonEncode(params));

      final response =
          await _dio.post(retailerDistributorTopupUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //distributor topup the account for retailer
  Future<dynamic> retailerDistributorRequestedTopup(var params) async {
    try {
      log(jsonEncode(params));

      final response =
          await _dio.post(retailerDistributorRequestedTopupUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //get distributor Request Report
  Future<DistributorRequestResponse?> getDistributorRequestReport(
    int requestFrom,
    int requestTo,
    int requestStatus,
    String fromDate,
    String toDate,
  ) async {
    try {
      var params = {
        "RequestFrom": requestFrom,
        "RequestTo": requestTo,
        "RequestStatus": requestStatus,
        "StartDate": fromDate,
        "EndDate": toDate,
      };
      log(jsonEncode(params));
      final response =
          await _dio.get(distributorRequestUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return DistributorRequestResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //Get Topup History Report
  Future<TopupHistoryResponse?> getTopupHistoryReport(
    int userId,
    int transType,
    String fromDate,
    String toDate,
  ) async {
    try {
      var params = {
        "SendeID": userId,
        "TransType": transType,
        "FromDate": fromDate,
        "ToDate": toDate,
      };
      log(jsonEncode(params));
      final response =
          await _dio.get(topupHistoryReportUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return TopupHistoryResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //DmtTRansaction Report
  Future<DmtReport?> getDmtReport(
      int userId, String fromDate, String toDate) async {
    try {
      var params = {
        "SendeID": userId,
        "StartDate": fromDate,
        "EndDate": toDate,
      };

      final response =
          await _dio.get(salesDmtReportUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return DmtReport.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  // get finance distributor REport List

  Future<DistributorRequestResponse?> getFIDistributorRequestReport(
    int requestFrom,
    int requestTo,
    int requestStatus,
    String fromDate,
    String toDate,
  ) async {
    try {
      var params = {
        "RequestFrom": requestFrom,
        "RequestTo": requestTo,
        "RequestStatus": requestStatus,
        "StartDate": fromDate,
        "EndDate": toDate,
      };
      log(jsonEncode(params));
      final response =
          await _dio.get(financeDITopupRequestUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return DistributorRequestResponse.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //get UsersDetails by role
  Future<UserList?> getUserDetailsByRole(
      String userId, String roleId, String showAll) async {
    try {
      var params = {"UserID": userId, "RoleID": roleId, "ShowAll": showAll};

      log(jsonEncode(params));

      final response =
          await _dio.get(userDetailsByRoleUrl, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return UserList.fromJson(response.data);
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //insert user finance and sales
  Future<dynamic> insertUserFinAndSale(var params) async {
    try {
      log(jsonEncode(params));

      final response = await _dio.post(userInsertFinAndSale, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }

  //insert user Retailer and distributor
  Future<dynamic> insertUserReAndDi(formData) async {
    try {
      log(formData.toString());

      final response = await _dio.post(userInsertReAndDi, data: formData);

      log('response code ${response.requestOptions.path} ${response.statusCode} $formData ${response.data}');

      return response.data;
    } on DioError catch (e) {
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
  }
}
