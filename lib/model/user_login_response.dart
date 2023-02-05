/// Status : true
/// StatusCode : 0
/// Message : "Login Sucessfully.."
/// ReturnData : {"ProofIDList":"","Profileimage":"","Aadharfront":"","Aadharback":"","PANfront":"","Bankagreefront":"","Bankagreeback":"","YYPagreefront":"","YYPagreeback":"","organisationname":"","organisationaddress":"","GSTIN":"","Aadharnumber":"","PANnumber":"","Id":6,"firstname":"Jayanthi  (RE-0006)","lastname":"Balan","mobileno":"9916921678","AppRoleID":6,"ProofID":1,"ProofImg":"20210106-224431133.jpg","IDProofImgUpload1":"","emailid":"jayanthisenthilnathan@gmail.com","MPIN":1695,"CreatedDate":"0001-01-01T00:00:00","CreatedById":0,"UpdatedDate":"0001-01-01T00:00:00","UpdatedById":0,"IsActive":true,"IsDeleted":false}

class UserLoginResponse {
  UserLoginResponse(
    this.status,
    this.message,
    this.userData,
  );

  UserLoginResponse.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    userData = UserData.fromJson(json['ReturnData']);
  }
  late bool status;
  late String message;
  late UserData userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    map['ReturnData'] = userData.toJson();
    return map;
  }
}

/// ProofIDList : ""
/// Profileimage : ""
/// Aadharfront : ""
/// Aadharback : ""
/// PANfront : ""
/// Bankagreefront : ""
/// Bankagreeback : ""
/// YYPagreefront : ""
/// YYPagreeback : ""
/// organisationname : ""
/// organisationaddress : ""
/// GSTIN : ""
/// Aadharnumber : ""
/// PANnumber : ""
/// Id : 6
/// firstname : "Jayanthi  (RE-0006)"
/// lastname : "Balan"
/// mobileno : "9916921678"
/// AppRoleID : 6
/// ProofID : 1
/// ProofImg : "20210106-224431133.jpg"
/// IDProofImgUpload1 : ""
/// emailid : "jayanthisenthilnathan@gmail.com"
/// MPIN : 1695
/// CreatedDate : "0001-01-01T00:00:00"
/// CreatedById : 0
/// UpdatedDate : "0001-01-01T00:00:00"
/// UpdatedById : 0
/// IsActive : true
/// IsDeleted : false

class UserData {
  UserData(
    this.proofIDList,
    this.profileimage,
    this.aadharfront,
    this.aadharback,
    this.pANfront,
    this.bankagreefront,
    this.bankagreeback,
    this.yYPagreefront,
    this.yYPagreeback,
    this.organisationname,
    this.organisationaddress,
    this.gstin,
    this.aadharnumber,
    this.pANnumber,
    this.id,
    this.firstname,
    this.lastname,
    this.mobileno,
    this.appRoleID,
    this.proofID,
    this.proofImg,
    this.iDProofImgUpload1,
    this.emailid,
    this.mpin,
    this.createdDate,
    this.createdById,
    this.updatedDate,
    this.updatedById,
    this.isActive,
    this.isDeleted,
  );

  UserData.fromJson(dynamic json) {
    proofIDList = json['ProofIDList'];
    profileimage = json['Profileimage'];
    aadharfront = json['Aadharfront'];
    aadharback = json['Aadharback'];
    pANfront = json['PANfront'];
    bankagreefront = json['Bankagreefront'];
    bankagreeback = json['Bankagreeback'];
    yYPagreefront = json['YYPagreefront'];
    yYPagreeback = json['YYPagreeback'];
    organisationname = json['organisationname'];
    organisationaddress = json['organisationaddress'];
    gstin = json['GSTIN'];
    aadharnumber = json['Aadharnumber'];
    pANnumber = json['PANnumber'];
    id = json['Id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    mobileno = json['mobileno'];
    appRoleID = json['AppRoleID'];
    proofID = json['ProofID'];
    proofImg = json['ProofImg'];
    iDProofImgUpload1 = json['IDProofImgUpload1'];
    emailid = json['emailid'];
    mpin = json['MPIN'];
    createdDate = json['CreatedDate'];
    createdById = json['CreatedById'];
    updatedDate = json['UpdatedDate'];
    updatedById = json['UpdatedById'];
    isActive = json['IsActive'];
    isDeleted = json['IsDeleted'];
  }
  late String proofIDList;
  late String profileimage;
  late String aadharfront;
  late String aadharback;
  late String pANfront;
  late String bankagreefront;
  late String bankagreeback;
  late String yYPagreefront;
  late String yYPagreeback;
  late String organisationname;
  late String organisationaddress;
  late String gstin;
  late String aadharnumber;
  late String pANnumber;
  late int id;
  late String firstname;
  late String lastname;
  late String mobileno;
  late int appRoleID;
  late int proofID;
  late String proofImg;
  late String iDProofImgUpload1;
  late String emailid;
  late int mpin;
  late String createdDate;
  late int createdById;
  late String updatedDate;
  late int updatedById;
  late bool isActive;
  late bool isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ProofIDList'] = proofIDList;
    map['Profileimage'] = profileimage;
    map['Aadharfront'] = aadharfront;
    map['Aadharback'] = aadharback;
    map['PANfront'] = pANfront;
    map['Bankagreefront'] = bankagreefront;
    map['Bankagreeback'] = bankagreeback;
    map['YYPagreefront'] = yYPagreefront;
    map['YYPagreeback'] = yYPagreeback;
    map['organisationname'] = organisationname;
    map['organisationaddress'] = organisationaddress;
    map['GSTIN'] = gstin;
    map['Aadharnumber'] = aadharnumber;
    map['PANnumber'] = pANnumber;
    map['Id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['mobileno'] = mobileno;
    map['AppRoleID'] = appRoleID;
    map['ProofID'] = proofID;
    map['ProofImg'] = proofImg;
    map['IDProofImgUpload1'] = iDProofImgUpload1;
    map['emailid'] = emailid;
    map['MPIN'] = mpin;
    map['CreatedDate'] = createdDate;
    map['CreatedById'] = createdById;
    map['UpdatedDate'] = updatedDate;
    map['UpdatedById'] = updatedById;
    map['IsActive'] = isActive;
    map['IsDeleted'] = isDeleted;
    return map;
  }
}
