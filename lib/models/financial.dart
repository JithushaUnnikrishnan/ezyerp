class Autogenerated {
  bool? flag;
  String? msg;
  List<FinancialYears>? financialYears;

  Autogenerated({this.flag, this.msg, this.financialYears});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    msg = json['msg'];
    if (json['financial_years'] != null) {
      financialYears = <FinancialYears>[];
      json['financial_years'].forEach((v) {
        financialYears!.add(new FinancialYears.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['msg'] = this.msg;
    if (this.financialYears != null) {
      data['financial_years'] =
          this.financialYears!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinancialYears {
  String? financeid;
  String? financialYear;
  String? status;

  FinancialYears({this.financeid, this.financialYear, this.status});

  FinancialYears.fromJson(Map<String, dynamic> json) {
    financeid = json['financeid'];
    financialYear = json['financial_year'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financeid'] = this.financeid;
    data['financial_year'] = this.financialYear;
    data['status'] = this.status;
    return data;
  }
}
