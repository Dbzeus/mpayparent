/// Status : true
/// StatusCode : 0
/// Message : "Transaction details loaded sucessfully.."
/// ReturnData : [{"TransID":32,"CustomerID":null,"Retailer":"Jayanthi  (RE-0006) (9916921678)","SenderName":"Jayanthi (9916921678)","ReceiverName":"JAYANTHI B (9916921678)","Amount":4,"bankName":"UNION BANK OF INDIA","accountNumber":"584202010012524","ifscCode":"UBIN0534994","ClientRefID":"10128020221126246483","TransactionID":"233013089056","Status":"Success / ","TransactionDate":"26-11-2022 01:31 PM","openingBalance":671.99,"ClosingBalance":667.99,"Transfer_Commission_Charge":0,"Retailer_Commission":0,"ParentID":5,"TransType":""}]

class DmtReport {
  DmtReport(
    this.status,
    this.statusCode,
    this.message,
    this.dmtData,
  );

  DmtReport.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      dmtData = [];
      json['ReturnData'].forEach((v) {
        dmtData.add(DmtReportData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<DmtReportData> dmtData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['StatusCode'] = statusCode;
    map['Message'] = message;
    if (dmtData != null) {
      map['ReturnData'] = dmtData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// TransID : 32
/// CustomerID : null
/// Retailer : "Jayanthi  (RE-0006) (9916921678)"
/// SenderName : "Jayanthi (9916921678)"
/// ReceiverName : "JAYANTHI B (9916921678)"
/// Amount : 4
/// bankName : "UNION BANK OF INDIA"
/// accountNumber : "584202010012524"
/// ifscCode : "UBIN0534994"
/// ClientRefID : "10128020221126246483"
/// TransactionID : "233013089056"
/// Status : "Success / "
/// TransactionDate : "26-11-2022 01:31 PM"
/// openingBalance : 671.99
/// ClosingBalance : 667.99
/// Transfer_Commission_Charge : 0
/// Retailer_Commission : 0
/// ParentID : 5
/// TransType : ""

class DmtReportData {
  DmtReportData(
    this.transID,
    this.customerID,
    this.retailer,
    this.senderName,
    this.receiverName,
    this.amount,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.clientRefID,
    this.transactionID,
    this.status,
    this.transactionDate,
    this.openingBalance,
    this.closingBalance,
    this.transferCommissionCharge,
    this.retailerCommission,
    this.parentID,
    this.transType,
  );

  DmtReportData.fromJson(dynamic json) {
    transID = json['TransID'];
    customerID = json['CustomerID'];
    retailer = json['Retailer'];
    senderName = json['SenderName'];
    receiverName = json['ReceiverName'];
    amount = json['Amount'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    ifscCode = json['ifscCode'];
    clientRefID = json['ClientRefID'];
    transactionID = json['TransactionID'];
    status = json['Status'];
    transactionDate = json['TransactionDate'];
    openingBalance = json['openingBalance'];
    closingBalance = json['ClosingBalance'];
    transferCommissionCharge = json['Transfer_Commission_Charge'];
    retailerCommission = json['Retailer_Commission'];
    parentID = json['ParentID'];
    transType = json['TransType'];
    charges = json['Charges'] ?? '';
  }
  late int transID;
  late dynamic customerID;
  late String retailer;
  late String senderName;
  late String receiverName;
  late double amount;
  late String bankName;
  late String accountNumber;
  late String ifscCode;
  late String clientRefID;
  late String transactionID;
  late String status;
  late String transactionDate;
  late double openingBalance;
  late double closingBalance;
  late double transferCommissionCharge;
  late double retailerCommission;
  late int parentID;
  late String transType;
  String charges = '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TransID'] = transID;
    map['CustomerID'] = customerID;
    map['Retailer'] = retailer;
    map['SenderName'] = senderName;
    map['ReceiverName'] = receiverName;
    map['Amount'] = amount;
    map['bankName'] = bankName;
    map['accountNumber'] = accountNumber;
    map['ifscCode'] = ifscCode;
    map['ClientRefID'] = clientRefID;
    map['TransactionID'] = transactionID;
    map['Status'] = status;
    map['TransactionDate'] = transactionDate;
    map['openingBalance'] = openingBalance;
    map['ClosingBalance'] = closingBalance;
    map['Transfer_Commission_Charge'] = transferCommissionCharge;
    map['Retailer_Commission'] = retailerCommission;
    map['ParentID'] = parentID;
    map['TransType'] = transType;
    return map;
  }
}
