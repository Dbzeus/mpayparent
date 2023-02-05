/// Status : true
/// StatusCode : 0
/// Message : "Distributor details loaded sucessfully.."
/// ReturnData : [{"UserID":6,"RoleID":6,"FirstName":"Jayanthi ","LastName":"Balan","MobileNo":"9916921678","RoleName":"Retailer","MPin":1695,"OTP":895055,"EmailID":"jayanthisenthilnathan@gmail.com","OrganisationName":"chrimata ","OrganisationAddress":"coimbatore ","GSTIN":"837c266b-bf09-4ad7-8f89-adaa6d7422ec.jpg","ProfilePhoto":"https://mpayy.dbzapps.com/UploadImages/105df05c-c0e7-4681-bc05-3d0b924f9389.jpg","AadharNumber":"814010117654","AadharFrontPhoto":"https://mpayy.dbzapps.com/UploadImages/2b84876a-4d27-4070-a14b-cdb1412458eb.jpg","AadharBackPhoto":"https://mpayy.dbzapps.com/UploadImages/80344ab3-2049-40b1-bbfe-2d2821990418.jpg","PANNo":"BTKPJ3944G","PANFrontImage":"https://mpayy.dbzapps.com/UploadImages/a1efbd54-a764-4ab6-afba-01ad18adebde.jpg","BankAgreementFrontPhoto":"https://mpayy.dbzapps.com/UploadImages/16558634-dc75-4b32-9a09-d46bd1ecb71e.jpg","BankAgreementBackPhoto":"https://mpayy.dbzapps.com/UploadImages/27022b94-4a37-408a-9ee8-29f3865923a3.jpg","YesYesAgreementFrontPhoto":"https://mpayy.dbzapps.com/UploadImages/7b22a16c-af1b-43ca-89dc-240aba7b932d.jpg","YesYesAgreementBackPhoto":"https://mpayy.dbzapps.com/UploadImages/e46b0b44-89ac-436f-add9-079de3fb800b.jpg","IsActive":true,"CUID":0,"CUDate":"0001-01-01T00:00:00","AEPSID":"123456","ParentID":5}]

class RetailerDetailsResponse {
  RetailerDetailsResponse(
    this.status,
    this.statusCode,
    this.message,
    this.returnData,
  );

  RetailerDetailsResponse.fromJson(dynamic json) {
    status = json['Status'];
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['ReturnData'] != null) {
      returnData = [];
      json['ReturnData'].forEach((v) {
        returnData.add(RetailerResponseReturnData.fromJson(v));
      });
    }
  }
  late bool status;
  late int statusCode;
  late String message;
  late List<RetailerResponseReturnData> returnData;

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
/// RoleID : 6
/// FirstName : "Jayanthi "
/// LastName : "Balan"
/// MobileNo : "9916921678"
/// RoleName : "Retailer"
/// MPin : 1695
/// OTP : 895055
/// EmailID : "jayanthisenthilnathan@gmail.com"
/// OrganisationName : "chrimata "
/// OrganisationAddress : "coimbatore "
/// GSTIN : "837c266b-bf09-4ad7-8f89-adaa6d7422ec.jpg"
/// ProfilePhoto : "https://mpayy.dbzapps.com/UploadImages/105df05c-c0e7-4681-bc05-3d0b924f9389.jpg"
/// AadharNumber : "814010117654"
/// AadharFrontPhoto : "https://mpayy.dbzapps.com/UploadImages/2b84876a-4d27-4070-a14b-cdb1412458eb.jpg"
/// AadharBackPhoto : "https://mpayy.dbzapps.com/UploadImages/80344ab3-2049-40b1-bbfe-2d2821990418.jpg"
/// PANNo : "BTKPJ3944G"
/// PANFrontImage : "https://mpayy.dbzapps.com/UploadImages/a1efbd54-a764-4ab6-afba-01ad18adebde.jpg"
/// BankAgreementFrontPhoto : "https://mpayy.dbzapps.com/UploadImages/16558634-dc75-4b32-9a09-d46bd1ecb71e.jpg"
/// BankAgreementBackPhoto : "https://mpayy.dbzapps.com/UploadImages/27022b94-4a37-408a-9ee8-29f3865923a3.jpg"
/// YesYesAgreementFrontPhoto : "https://mpayy.dbzapps.com/UploadImages/7b22a16c-af1b-43ca-89dc-240aba7b932d.jpg"
/// YesYesAgreementBackPhoto : "https://mpayy.dbzapps.com/UploadImages/e46b0b44-89ac-436f-add9-079de3fb800b.jpg"
/// IsActive : true
/// CUID : 0
/// CUDate : "0001-01-01T00:00:00"
/// AEPSID : "123456"
/// ParentID : 5

class RetailerResponseReturnData {
  RetailerResponseReturnData(
    this.userID,
    this.roleID,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.roleName,
    this.mPin,
    this.otp,
    this.emailID,
    this.organisationName,
    this.organisationAddress,
    this.gstin,
    this.profilePhoto,
    this.aadharNumber,
    this.aadharFrontPhoto,
    this.aadharBackPhoto,
    this.pANNo,
    this.pANFrontImage,
    this.bankAgreementFrontPhoto,
    this.bankAgreementBackPhoto,
    this.yesYesAgreementFrontPhoto,
    this.yesYesAgreementBackPhoto,
    this.isActive,
    this.cuid,
    this.cUDate,
    this.aepsid,
    this.parentID,
  );

  RetailerResponseReturnData.fromJson(dynamic json) {
    userID = json['UserID'];
    roleID = json['RoleID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNo = json['MobileNo'];
    roleName = json['RoleName'];
    mPin = json['MPin'];
    otp = json['OTP'];
    emailID = json['EmailID'];
    organisationName = json['OrganisationName'];
    organisationAddress = json['OrganisationAddress'];
    gstin = json['GSTIN'];
    profilePhoto = json['ProfilePhoto'];
    aadharNumber = json['AadharNumber'];
    aadharFrontPhoto = json['AadharFrontPhoto'];
    aadharBackPhoto = json['AadharBackPhoto'];
    pANNo = json['PANNo'];
    pANFrontImage = json['PANFrontImage'];
    bankAgreementFrontPhoto = json['BankAgreementFrontPhoto'];
    bankAgreementBackPhoto = json['BankAgreementBackPhoto'];
    yesYesAgreementFrontPhoto = json['YesYesAgreementFrontPhoto'];
    yesYesAgreementBackPhoto = json['YesYesAgreementBackPhoto'];
    isActive = json['IsActive'];
    cuid = json['CUID'];
    cUDate = json['CUDate'];
    aepsid = json['AEPSID'];
    parentID = json['ParentID'];
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
  late String organisationName;
  late String organisationAddress;
  late String gstin;
  late String profilePhoto;
  late String aadharNumber;
  late String aadharFrontPhoto;
  late String aadharBackPhoto;
  late String pANNo;
  late String pANFrontImage;
  late String bankAgreementFrontPhoto;
  late String bankAgreementBackPhoto;
  late String yesYesAgreementFrontPhoto;
  late String yesYesAgreementBackPhoto;
  late bool isActive;
  late int cuid;
  late String cUDate;
  late String aepsid;
  late int parentID;

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
    map['OrganisationName'] = organisationName;
    map['OrganisationAddress'] = organisationAddress;
    map['GSTIN'] = gstin;
    map['ProfilePhoto'] = profilePhoto;
    map['AadharNumber'] = aadharNumber;
    map['AadharFrontPhoto'] = aadharFrontPhoto;
    map['AadharBackPhoto'] = aadharBackPhoto;
    map['PANNo'] = pANNo;
    map['PANFrontImage'] = pANFrontImage;
    map['BankAgreementFrontPhoto'] = bankAgreementFrontPhoto;
    map['BankAgreementBackPhoto'] = bankAgreementBackPhoto;
    map['YesYesAgreementFrontPhoto'] = yesYesAgreementFrontPhoto;
    map['YesYesAgreementBackPhoto'] = yesYesAgreementBackPhoto;
    map['IsActive'] = isActive;
    map['CUID'] = cuid;
    map['CUDate'] = cUDate;
    map['AEPSID'] = aepsid;
    map['ParentID'] = parentID;
    return map;
  }
}
