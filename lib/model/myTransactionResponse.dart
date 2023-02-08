/// Status : true
/// StatusCode : 0
/// Message : "Transaction details loaded sucessfully.."
/// ReturnData : [{"TransID":"10128084","TransactionDate":"02-06-2023 11:55 AM","UserName":"","Narration":"DMT & AEPS Commission Paid (5% Tax deducted) 06-02-2023","OpeningBalance":1500.95,"Credit":7.6,"Debit":0,"TransValue":0,"Charges":0,"Commission":7.6,"TotalCommission":0,"Tax":0.4,"ClosingBalance":1508.55,"Description":"","TransType":"Commission Paid"}]

class MyTransactionResponse {
  MyTransactionResponse(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  MyTransactionResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(MyTransactionResponseReturnData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<MyTransactionResponseReturnData> returnData;

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

/// TransID : "10128084"
/// TransactionDate : "02-06-2023 11:55 AM"
/// UserName : ""
/// Narration : "DMT & AEPS Commission Paid (5% Tax deducted) 06-02-2023"
/// OpeningBalance : 1500.95
/// Credit : 7.6
/// Debit : 0
/// TransValue : 0
/// Charges : 0
/// Commission : 7.6
/// TotalCommission : 0
/// Tax : 0.4
/// ClosingBalance : 1508.55
/// Description : ""
/// TransType : "Commission Paid"

class MyTransactionResponseReturnData {
  MyTransactionResponseReturnData(
    this.transID,
    this.transactionDate,
    this.userName,
    this.narration,
    this.openingBalance,
    this.credit,
    this.debit,
    this.transValue,
    this.charges,
    this.commission,
    this.totalCommission,
    this.tax,
    this.closingBalance,
    this.description,
    this.transType,
  );

  MyTransactionResponseReturnData.fromJson(dynamic json) {
    transID = json['TransID'];
    transactionDate = json['TransactionDate'];
    userName = json['UserName'];
    narration = json['Narration'];
    openingBalance = json['OpeningBalance'];
    credit = json['Credit'];
    debit = json['Debit'];
    transValue = json['TransValue'];
    charges = json['Charges'];
    commission = json['Commission'];
    totalCommission = json['TotalCommission'];
    tax = json['Tax'];
    closingBalance = json['ClosingBalance'];
    description = json['Description'];
    transType = json['TransType'];
  }
  late String transID;
  late String transactionDate;
  late String userName;
  late String narration;
  late double openingBalance;
  late double credit;
  late double debit;
  late double transValue;
  late double charges;
  late double commission;
  late double totalCommission;
  late double tax;
  late double closingBalance;
  late String description;
  late String transType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TransID'] = transID;
    map['TransactionDate'] = transactionDate;
    map['UserName'] = userName;
    map['Narration'] = narration;
    map['OpeningBalance'] = openingBalance;
    map['Credit'] = credit;
    map['Debit'] = debit;
    map['TransValue'] = transValue;
    map['Charges'] = charges;
    map['Commission'] = commission;
    map['TotalCommission'] = totalCommission;
    map['Tax'] = tax;
    map['ClosingBalance'] = closingBalance;
    map['Description'] = description;
    map['TransType'] = transType;
    return map;
  }
}
