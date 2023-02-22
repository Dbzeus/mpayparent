/// Status : true
/// StatusCode : 0
/// Message : "User details loaded sucessfully.."
/// ReturnData : [{"UserID":3,"RoleID":3,"FirstName":"J M","LastName":"Arun","MobileNo":"9663122799","RoleName":"Finance","MPin":3834,"OTP":980589,"EmailID":"ojsanthosh@gmail.com","Zone":"","Remarks":"Finance User creation ","ProfileImage":"","OrganisationName":"","IsActive":true,"CUID":0,"CUDate":"0001-01-01T00:00:00"}]

class UserList {
  UserList(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  UserList.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(UserListReturnData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<UserListReturnData> returnData;

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

/// UserID : 3
/// RoleID : 3
/// FirstName : "J M"
/// LastName : "Arun"
/// MobileNo : "9663122799"
/// RoleName : "Finance"
/// MPin : 3834
/// OTP : 980589
/// EmailID : "ojsanthosh@gmail.com"
/// Zone : ""
/// Remarks : "Finance User creation "
/// ProfileImage : ""
/// OrganisationName : ""
/// IsActive : true
/// CUID : 0
/// CUDate : "0001-01-01T00:00:00"

class UserListReturnData {
  UserListReturnData(
    this.userID,
    this.roleID,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.roleName,
    this.mPin,
    this.otp,
    this.emailID,
    this.zone,
    this.remarks,
    this.profileImage,
    this.organisationName,
    this.isActive,
    this.cuid,
    this.cUDate,
  );

  UserListReturnData.fromJson(dynamic json) {
    userID = json['UserID'];
    roleID = json['RoleID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNo = json['MobileNo'];
    roleName = json['RoleName'];
    mPin = json['MPin'];
    otp = json['OTP'];
    emailID = json['EmailID'];
    zone = json['Zone'];
    remarks = json['Remarks'];
    profileImage = json['ProfileImage'];
    organisationName = json['OrganisationName'];
    isActive = json['IsActive'];
    cuid = json['CUID'];
    cUDate = json['CUDate'];
  }
  late int userID;
  late int roleID;
  late String firstName;
  late String lastName;
  late String mobileNo;
  late String roleName;
  late int mPin;
  late int otp;
  late String emailID;
  late String zone;
  late String remarks;
  late String profileImage;
  late String organisationName;
  late bool isActive;
  late int cuid;
  late String cUDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['RoleID'] = roleID;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['MobileNo'] = mobileNo;
    map['RoleName'] = roleName;
    map['MPin'] = mPin;
    map['OTP'] = otp;
    map['EmailID'] = emailID;
    map['Zone'] = zone;
    map['Remarks'] = remarks;
    map['ProfileImage'] = profileImage;
    map['OrganisationName'] = organisationName;
    map['IsActive'] = isActive;
    map['CUID'] = cuid;
    map['CUDate'] = cUDate;
    return map;
  }
}
