/// Status : true
/// StatusCode : 0
/// Message : "77358.89"
/// ReturnData : [{"UserID":6,"FirstName":"Jayanthi  (RE-0006)","Amount":76884.27,"AEPSAmount":0,"Remarks":null,"MobileNo":"9916921678","RoleID":6}]

class BalanceReportResponse {
  BalanceReportResponse(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  BalanceReportResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(BalanceReportResponseData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<BalanceReportResponseData> returnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['StatusCode'] = statusCode;
    map['Message'] = message;
    if (returnData != null) {
      map['ReturnData'] = returnData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// UserID : 6
/// FirstName : "Jayanthi  (RE-0006)"
/// Amount : 76884.27
/// AEPSAmount : 0
/// Remarks : null
/// MobileNo : "9916921678"
/// RoleID : 6

class BalanceReportResponseData {
  BalanceReportResponseData(
    this.userID,
    this.firstName,
    this.amount,
    this.aEPSAmount,
    this.remarks,
    this.mobileNo,
    this.roleID,
  );

  BalanceReportResponseData.fromJson(dynamic json) {
    userID = json['UserID'];
    firstName = json['FirstName'];
    amount = json['Amount'];
    aEPSAmount = json['AEPSAmount'];
    remarks = json['Remarks'];
    mobileNo = json['MobileNo'];
    roleID = json['RoleID'];
  }
  late int userID;
  late String firstName;
  late double amount;
  late double aEPSAmount;
  late dynamic remarks;
  late String mobileNo;
  late int roleID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['Amount'] = amount;
    map['AEPSAmount'] = aEPSAmount;
    map['Remarks'] = remarks;
    map['MobileNo'] = mobileNo;
    map['RoleID'] = roleID;
    return map;
  }
}
