// login_response.dart
class LoginResponse {
  final bool flag;
  final String msg;
  final Employee employee;

  LoginResponse({
    required this.flag,
    required this.msg,
    required this.employee,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      flag: json['flag'],
      msg: json['msg'],
      employee: Employee.fromJson(json['employee']),
    );
  }
}

class Employee {
  final String userid;
  final String employeeid;
  final String username;
  final String employeeName;
  final String address;
  final String mobileno;
  final String whatsappno;
  final String emailid;
  final String joinDate;
  final String dob;
  final String gender;
  final String employeeStatus;
  final String usertype;
  final String usertypeid;
  final String officeid;
  final String taxEst;
  final String accounttype;
  final String gstno;
  final String officename;
  final String officeAddress;
  final String pincode;
  final String location;
  final String stateId;
  final String stateName;
  final String stateCode;
  final String tinNo;
  final String countryId;
  final String countryName;
  final String countryCode;
  final String? fssai; // Nullable field
  final String officeEmailId;
  final String officeMobileNo;
  final String? website; // Nullable field
  final String? logo; // Nullable field
  final String officetypeid;
  final String officetype;
  final String offStatus;
  final String billType;
  final String officeBill;
  final String financialYearId;
  final String financialYear;
  final String fyStartDate;
  final String fyEndDate;
  final String fyStatus;
  final String imageUrl;

  Employee({
    required this.userid,
    required this.employeeid,
    required this.username,
    required this.employeeName,
    required this.address,
    required this.mobileno,
    required this.whatsappno,
    required this.emailid,
    required this.joinDate,
    required this.dob,
    required this.gender,
    required this.employeeStatus,
    required this.usertype,
    required this.usertypeid,
    required this.officeid,
    required this.taxEst,
    required this.accounttype,
    required this.gstno,
    required this.officename,
    required this.officeAddress,
    required this.pincode,
    required this.location,
    required this.stateId,
    required this.stateName,
    required this.stateCode,
    required this.tinNo,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    this.fssai,
    required this.officeEmailId,
    required this.officeMobileNo,
    this.website,
    this.logo,
    required this.officetypeid,
    required this.officetype,
    required this.offStatus,
    required this.billType,
    required this.officeBill,
    required this.financialYearId,
    required this.financialYear,
    required this.fyStartDate,
    required this.fyEndDate,
    required this.fyStatus,
    required this.imageUrl,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      userid: json['userid'],
      employeeid: json['employeeid'],
      username: json['username'],
      employeeName: json['employee_name'],
      address: json['address'] ?? '', // Default to empty string if null
      mobileno: json['mobileno'],
      whatsappno: json['whatsappno'] ?? '',
      emailid: json['emailid'] ?? '',
      joinDate: json['join_date'],
      dob: json['dob'],
      gender: json['gender'],
      employeeStatus: json['employee_status'],
      usertype: json['usertype'],
      usertypeid: json['usertypeid'],
      officeid: json['officeid'],
      taxEst: json['tax_est'],
      accounttype: json['accounttype'] ?? '',
      gstno: json['gstno'],
      officename: json['officename'],
      officeAddress: json['office_address'],
      pincode: json['pincode'],
      location: json['location'],
      stateId: json['state_id'],
      stateName: json['state_name'],
      stateCode: json['state_code'],
      tinNo: json['tin_no'],
      countryId: json['country_id'],
      countryName: json['country_name'],
      countryCode: json['country_code'],
      fssai: json['fssai'], // Nullable field
      officeEmailId: json['office_emailid'],
      officeMobileNo: json['office_mobileno'],
      website: json['website'], // Nullable field
      logo: json['logo'], // Nullable field
      officetypeid: json['officetypeid'],
      officetype: json['officetype'],
      offStatus: json['off_status'],
      billType: json['bill_type'],
      officeBill: json['OfficeBill'],
      financialYearId: json['financialyearid'],
      financialYear: json['financialyear'],
      fyStartDate: json['fystartdate'],
      fyEndDate: json['fyeenddate'],
      fyStatus: json['fystatus'],
      imageUrl: json['image_url'],
    );
  }
}
