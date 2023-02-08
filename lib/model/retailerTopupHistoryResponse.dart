/// Status : true
/// StatusCode : 0
/// Message : "Topup details loaded sucessfully.."
/// ReturnData : [{"TransID":15,"TransFrom":5,"TransTo":7,"TransactionDate":"07-02-2023","TransFromName":"Mpayy (DI-0005)","TransToName":"Sathya (RE-0007)","Time":"4:39PM","MobileNo":"9108259595","ToRole":"Retailer","TrToMobile":"6383083964","TransValue":200,"OpeningBalanceTrFr":1308.55,"OpeningBalanceTrTo":0,"ClosingBalanceTrFr":1108.55,"ClosingBalanceTrTo":200,"Description":"Mpayy (DI-0005) To Sathya (RE-0007)","CreatedDate":"2023-02-07T16:39:38.967","Remarks":"demo "}]

class RetailerTopupHistoryResponse {
  RetailerTopupHistoryResponse(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  RetailerTopupHistoryResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(RetailerTopupHistoryResponseReturnData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<RetailerTopupHistoryResponseReturnData> returnData;

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

/// TransID : 15
/// TransFrom : 5
/// TransTo : 7
/// TransactionDate : "07-02-2023"
/// TransFromName : "Mpayy (DI-0005)"
/// TransToName : "Sathya (RE-0007)"
/// Time : "4:39PM"
/// MobileNo : "9108259595"
/// ToRole : "Retailer"
/// TrToMobile : "6383083964"
/// TransValue : 200
/// OpeningBalanceTrFr : 1308.55
/// OpeningBalanceTrTo : 0
/// ClosingBalanceTrFr : 1108.55
/// ClosingBalanceTrTo : 200
/// Description : "Mpayy (DI-0005) To Sathya (RE-0007)"
/// CreatedDate : "2023-02-07T16:39:38.967"
/// Remarks : "demo "

class RetailerTopupHistoryResponseReturnData {
  RetailerTopupHistoryResponseReturnData(
    this.transID,
    this.transFrom,
    this.transTo,
    this.transactionDate,
    this.transFromName,
    this.transToName,
    this.time,
    this.mobileNo,
    this.toRole,
    this.trToMobile,
    this.transValue,
    this.openingBalanceTrFr,
    this.openingBalanceTrTo,
    this.closingBalanceTrFr,
    this.closingBalanceTrTo,
    this.description,
    this.createdDate,
    this.remarks,
  );

  RetailerTopupHistoryResponseReturnData.fromJson(dynamic json) {
    transID = json['TransID'];
    transFrom = json['TransFrom'];
    transTo = json['TransTo'];
    transactionDate = json['TransactionDate'];
    transFromName = json['TransFromName'];
    transToName = json['TransToName'];
    time = json['Time'];
    mobileNo = json['MobileNo'];
    toRole = json['ToRole'];
    trToMobile = json['TrToMobile'];
    transValue = json['TransValue'];
    openingBalanceTrFr = json['OpeningBalanceTrFr'];
    openingBalanceTrTo = json['OpeningBalanceTrTo'];
    closingBalanceTrFr = json['ClosingBalanceTrFr'];
    closingBalanceTrTo = json['ClosingBalanceTrTo'];
    description = json['Description'];
    createdDate = json['CreatedDate'];
    remarks = json['Remarks'];
  }
  late int transID;
  late int transFrom;
  late int transTo;
  late String transactionDate;
  late String transFromName;
  late String transToName;
  late String time;
  late String mobileNo;
  late String toRole;
  late String trToMobile;
  late double transValue;
  late double openingBalanceTrFr;
  late double openingBalanceTrTo;
  late double closingBalanceTrFr;
  late double closingBalanceTrTo;
  late String description;
  late String createdDate;
  late String remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TransID'] = transID;
    map['TransFrom'] = transFrom;
    map['TransTo'] = transTo;
    map['TransactionDate'] = transactionDate;
    map['TransFromName'] = transFromName;
    map['TransToName'] = transToName;
    map['Time'] = time;
    map['MobileNo'] = mobileNo;
    map['ToRole'] = toRole;
    map['TrToMobile'] = trToMobile;
    map['TransValue'] = transValue;
    map['OpeningBalanceTrFr'] = openingBalanceTrFr;
    map['OpeningBalanceTrTo'] = openingBalanceTrTo;
    map['ClosingBalanceTrFr'] = closingBalanceTrFr;
    map['ClosingBalanceTrTo'] = closingBalanceTrTo;
    map['Description'] = description;
    map['CreatedDate'] = createdDate;
    map['Remarks'] = remarks;
    return map;
  }
}
