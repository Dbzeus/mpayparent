/// Status : true
/// StatusCode : 0
/// Message : "Topup Requester details loaded sucessfully.."
/// ReturnData : [{"TopupReqID":23,"ReqName":"Mpayy (DI-0005)","ReqAmt":2000,"Wallet":0,"ReqDate":"2023-02-07T16:40:25.517","RequestStatus":"Waiting for Approved","BankName":"CUB(510909010202068)","ProofImage":"","Remarks":"demo"}]

class DistributorRequestResponse {
  DistributorRequestResponse(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  DistributorRequestResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(DistributorRequestResponseReturnData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<DistributorRequestResponseReturnData> returnData;

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

/// TopupReqID : 23
/// ReqName : "Mpayy (DI-0005)"
/// ReqAmt : 2000
/// Wallet : 0
/// ReqDate : "2023-02-07T16:40:25.517"
/// RequestStatus : "Waiting for Approved"
/// BankName : "CUB(510909010202068)"
/// ProofImage : ""
/// Remarks : "demo"

class DistributorRequestResponseReturnData {
  DistributorRequestResponseReturnData(
    this.topupReqID,
    this.reqName,
    this.reqAmt,
    this.wallet,
    this.reqDate,
    this.requestStatus,
    this.bankName,
    this.proofImage,
    this.remarks,
  );

  DistributorRequestResponseReturnData.fromJson(dynamic json) {
    topupReqID = json['TopupReqID'];
    reqName = json['ReqName'];
    reqAmt = json['ReqAmt'];
    wallet = json['Wallet'];
    reqDate = json['ReqDate'];
    requestStatus = json['RequestStatus'];
    bankName = json['BankName'];
    proofImage = json['ProofImage'];
    remarks = json['Remarks'];
  }
  late int topupReqID;
  late String reqName;
  late double reqAmt;
  late double wallet;
  late String reqDate;
  late String requestStatus;
  late String bankName;
  late String proofImage;
  late String remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TopupReqID'] = topupReqID;
    map['ReqName'] = reqName;
    map['ReqAmt'] = reqAmt;
    map['Wallet'] = wallet;
    map['ReqDate'] = reqDate;
    map['RequestStatus'] = requestStatus;
    map['BankName'] = bankName;
    map['ProofImage'] = proofImage;
    map['Remarks'] = remarks;
    return map;
  }
}
