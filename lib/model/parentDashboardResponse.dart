/// Status : true
/// StatusCode : 0
/// Message : "Parent dashboard details loaded  sucessfully.."
/// ReturnData : [{"BCB":"5060.49","Paysprint":"19374.02","PCB":"5018.70","FCB":"2000.00","DCB":"1910.45","RCB":"9426.63","TCC":"110.00","RC":"36.63","DC":"10.45","PC":"18.70","TotalTransactionValue":"106614.00","TotalTransactionCount":"116","TotalNoofCustomer":"19","TotalCommission":null,"TotalProfitPercent":null,"CMTransactionValue":"1600.00","CMTransactionCount":"11","CMNoofCustomer":"3","CMCommission":null,"CMProfitPercent":null,"TodayTransactionValue":"0","TodayTransactionCount":"0","TodayNoofCustomer":"0","TodayCommission":null,"TodayProfitPercent":null}]

class ParentDashboardResponse {
  ParentDashboardResponse(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  ParentDashboardResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(ParentDashboardResponseReturnData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<ParentDashboardResponseReturnData> returnData;

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

/// BCB : "5060.49"
/// Paysprint : "19374.02"
/// PCB : "5018.70"
/// FCB : "2000.00"
/// DCB : "1910.45"
/// RCB : "9426.63"
/// TCC : "110.00"
/// RC : "36.63"
/// DC : "10.45"
/// PC : "18.70"
/// TotalTransactionValue : "106614.00"
/// TotalTransactionCount : "116"
/// TotalNoofCustomer : "19"
/// TotalCommission : null
/// TotalProfitPercent : null
/// CMTransactionValue : "1600.00"
/// CMTransactionCount : "11"
/// CMNoofCustomer : "3"
/// CMCommission : null
/// CMProfitPercent : null
/// TodayTransactionValue : "0"
/// TodayTransactionCount : "0"
/// TodayNoofCustomer : "0"
/// TodayCommission : null
/// TodayProfitPercent : null

class ParentDashboardResponseReturnData {
  ParentDashboardResponseReturnData(
    this.bcb,
    this.paysprint,
    this.pcb,
    this.fcb,
    this.dcb,
    this.rcb,
    this.tcc,
    this.rc,
    this.dc,
    this.pc,
    this.totalTransactionValue,
    this.totalTransactionCount,
    this.totalNoofCustomer,
    this.totalCommission,
    this.totalProfitPercent,
    this.cMTransactionValue,
    this.cMTransactionCount,
    this.cMNoofCustomer,
    this.cMCommission,
    this.cMProfitPercent,
    this.todayTransactionValue,
    this.todayTransactionCount,
    this.todayNoofCustomer,
    this.todayCommission,
    this.todayProfitPercent,
  );

  ParentDashboardResponseReturnData.fromJson(dynamic json) {
    bcb = json['BCB'];
    paysprint = json['Paysprint'];
    pcb = json['PCB'];
    fcb = json['FCB'];
    dcb = json['DCB'];
    rcb = json['RCB'];
    tcc = json['TCC'];
    rc = json['RC'];
    dc = json['DC'];
    pc = json['PC'];
    totalTransactionValue = json['TotalTransactionValue'];
    totalTransactionCount = json['TotalTransactionCount'];
    totalNoofCustomer = json['TotalNoofCustomer'];
    totalCommission = json['TotalCommission'];
    totalProfitPercent = json['TotalProfitPercent'];
    cMTransactionValue = json['CMTransactionValue'];
    cMTransactionCount = json['CMTransactionCount'];
    cMNoofCustomer = json['CMNoofCustomer'];
    cMCommission = json['CMCommission'];
    cMProfitPercent = json['CMProfitPercent'];
    todayTransactionValue = json['TodayTransactionValue'];
    todayTransactionCount = json['TodayTransactionCount'];
    todayNoofCustomer = json['TodayNoofCustomer'];
    todayCommission = json['TodayCommission'];
    todayProfitPercent = json['TodayProfitPercent'];
  }
  late String bcb;
  late String paysprint;
  late String pcb;
  late String fcb;
  late String dcb;
  late String rcb;
  late String tcc;
  late String rc;
  late String dc;
  late String pc;
  late String totalTransactionValue;
  late String totalTransactionCount;
  late String totalNoofCustomer;
  late dynamic totalCommission;
  late dynamic totalProfitPercent;
  late String cMTransactionValue;
  late String cMTransactionCount;
  late String cMNoofCustomer;
  late dynamic cMCommission;
  late dynamic cMProfitPercent;
  late String todayTransactionValue;
  late String todayTransactionCount;
  late String todayNoofCustomer;
  late dynamic todayCommission;
  late dynamic todayProfitPercent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BCB'] = bcb;
    map['Paysprint'] = paysprint;
    map['PCB'] = pcb;
    map['FCB'] = fcb;
    map['DCB'] = dcb;
    map['RCB'] = rcb;
    map['TCC'] = tcc;
    map['RC'] = rc;
    map['DC'] = dc;
    map['PC'] = pc;
    map['TotalTransactionValue'] = totalTransactionValue;
    map['TotalTransactionCount'] = totalTransactionCount;
    map['TotalNoofCustomer'] = totalNoofCustomer;
    map['TotalCommission'] = totalCommission;
    map['TotalProfitPercent'] = totalProfitPercent;
    map['CMTransactionValue'] = cMTransactionValue;
    map['CMTransactionCount'] = cMTransactionCount;
    map['CMNoofCustomer'] = cMNoofCustomer;
    map['CMCommission'] = cMCommission;
    map['CMProfitPercent'] = cMProfitPercent;
    map['TodayTransactionValue'] = todayTransactionValue;
    map['TodayTransactionCount'] = todayTransactionCount;
    map['TodayNoofCustomer'] = todayNoofCustomer;
    map['TodayCommission'] = todayCommission;
    map['TodayProfitPercent'] = todayProfitPercent;
    return map;
  }
}
