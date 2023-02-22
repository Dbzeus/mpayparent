/// UserID : 0
/// RoleID : 0
/// FirstName : "string"
/// LastName : "string"
/// MobileNo : "string"
/// RoleName : "string"
/// MPin : 0
/// OTP : 0
/// EmailID : "string"
/// Zone : "string"
/// Remarks : "string"
/// ProfileImage : "string"
/// OrganisationName : "string"
/// IsActive : true
/// CUID : 0
/// CUDate : "2023-02-22T05:39:50.719Z"

class UserFinSale {
  UserFinSale(
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

  UserFinSale.fromJson(dynamic json) {
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
