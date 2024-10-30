class LoginModel {
  bool? flag;
  String? msg;
  Employee? employee;

  LoginModel({this.flag, this.msg, this.employee});

  LoginModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    msg = json['msg'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['msg'] = this.msg;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class Employee {
  String? userid;
  String? employeeid;
  String? status;
  String? employeeName;
  String? address;
  String? dob;
  String? gender;
  String? mobileno;
  String? whatsappno;
  String? emailid;
  String? joinDate;
  Null? photo;
  String? usertypeid;
  String? employeeStatus;
  String? officeid;
  String? gstno;
  String? officename;
  String? officeAddress;
  String? pincode;
  String? stateName;
  String? stateCode;
  String? tinNo;
  String? countryName;
  String? countryCode;
  String? location;
  String? officeMobileno;
  String? officeEmailid;
  Null? website;
  Null? logo;
  String? officetypeid;
  String? officetype;
  String? usertype;
  String? username;
  String? countryId;
  String? stateId;
  Null? fssai;
  String? offStatus;
  String? financialyearid;
  String? financialyear;
  String? fystartdate;
  String? fyeenddate;
  String? fystatus;
  String? imageUrl;

  Employee(
      {this.userid,
        this.employeeid,
        this.status,
        this.employeeName,
        this.address,
        this.dob,
        this.gender,
        this.mobileno,
        this.whatsappno,
        this.emailid,
        this.joinDate,
        this.photo,
        this.usertypeid,
        this.employeeStatus,
        this.officeid,
        this.gstno,
        this.officename,
        this.officeAddress,
        this.pincode,
        this.stateName,
        this.stateCode,
        this.tinNo,
        this.countryName,
        this.countryCode,
        this.location,
        this.officeMobileno,
        this.officeEmailid,
        this.website,
        this.logo,
        this.officetypeid,
        this.officetype,
        this.usertype,
        this.username,
        this.countryId,
        this.stateId,
        this.fssai,
        this.offStatus,
        this.financialyearid,
        this.financialyear,
        this.fystartdate,
        this.fyeenddate,
        this.fystatus,
        this.imageUrl});

  Employee.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    employeeid = json['employeeid'];
    status = json['status'];
    employeeName = json['employee_name'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
    mobileno = json['mobileno'];
    whatsappno = json['whatsappno'];
    emailid = json['emailid'];
    joinDate = json['join_date'];
    photo = json['photo'];
    usertypeid = json['usertypeid'];
    employeeStatus = json['employee_status'];
    officeid = json['officeid'];
    gstno = json['gstno'];
    officename = json['officename'];
    officeAddress = json['office_address'];
    pincode = json['pincode'];
    stateName = json['state_name'];
    stateCode = json['state_code'];
    tinNo = json['tin_no'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    location = json['location'];
    officeMobileno = json['office_mobileno'];
    officeEmailid = json['office_emailid'];
    website = json['website'];
    logo = json['logo'];
    officetypeid = json['officetypeid'];
    officetype = json['officetype'];
    usertype = json['usertype'];
    username = json['username'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    fssai = json['fssai'];
    offStatus = json['off_status'];
    financialyearid = json['financialyearid'];
    financialyear = json['financialyear'];
    fystartdate = json['fystartdate'];
    fyeenddate = json['fyeenddate'];
    fystatus = json['fystatus'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['employeeid'] = this.employeeid;
    data['status'] = this.status;
    data['employee_name'] = this.employeeName;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['mobileno'] = this.mobileno;
    data['whatsappno'] = this.whatsappno;
    data['emailid'] = this.emailid;
    data['join_date'] = this.joinDate;
    data['photo'] = this.photo;
    data['usertypeid'] = this.usertypeid;
    data['employee_status'] = this.employeeStatus;
    data['officeid'] = this.officeid;
    data['gstno'] = this.gstno;
    data['officename'] = this.officename;
    data['office_address'] = this.officeAddress;
    data['pincode'] = this.pincode;
    data['state_name'] = this.stateName;
    data['state_code'] = this.stateCode;
    data['tin_no'] = this.tinNo;
    data['country_name'] = this.countryName;
    data['country_code'] = this.countryCode;
    data['location'] = this.location;
    data['office_mobileno'] = this.officeMobileno;
    data['office_emailid'] = this.officeEmailid;
    data['website'] = this.website;
    data['logo'] = this.logo;
    data['officetypeid'] = this.officetypeid;
    data['officetype'] = this.officetype;
    data['usertype'] = this.usertype;
    data['username'] = this.username;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['fssai'] = this.fssai;
    data['off_status'] = this.offStatus;
    data['financialyearid'] = this.financialyearid;
    data['financialyear'] = this.financialyear;
    data['fystartdate'] = this.fystartdate;
    data['fyeenddate'] = this.fyeenddate;
    data['fystatus'] = this.fystatus;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
