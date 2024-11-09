class CustomerStatement {
  final String? expincId;
  final String? alltype;
  final String? pinvtype;
  final String purDate;
  final String? customerName;
  final String? alltypes;
  final String? incout1;
  final String? incin1;
  final String? expout;
  final String? expin;
  final String? incout;
  final String? incin;
  final String? ob;
  final String? invoice;
  final String? pinvoice;
  final String? chequeno;
  final String? chDate;
  final String? remarks;
  final String msg;
  final bool flag;

  CustomerStatement({
    this.expincId,
    this.alltype,
    this.pinvtype,
    required this.purDate,
    this.customerName,
    this.alltypes,
    this.incout1,
    this.incin1,
    this.expout,
    this.expin,
    this.incout,
    this.incin,
    this.ob,
    this.invoice,
    this.pinvoice,
    this.chequeno,
    this.chDate,
    this.remarks,
    required this.msg,
    required this.flag,
  });

  factory CustomerStatement.fromJson(Map<String, dynamic> json) {
    return CustomerStatement(
      expincId: json['expincId'] as String?,
      alltype: json['alltype'] as String?,
      pinvtype: json['pinvtype'] as String?,
      purDate: json['pur_date'] ?? '',
      customerName: json['customer_name'] as String?,
      alltypes: json['alltypes'] as String?,
      incout1: json['incout1'] as String?,
      incin1: json['incin1'] as String?,
      expout: json['expout'] as String?,
      expin: json['expin'] as String?,
      incout: json['incout'] as String?,
      incin: json['incin'] as String?,
      ob: json['ob'] as String?,
      invoice: json['invoice'] as String?,
      pinvoice: json['pinvoice'] as String?,
      chequeno: json['chequeno'] as String?,
      chDate: json['ch_date'] as String?,
      remarks: json['remarks'] as String?,
      msg: json['msg'] ?? '',
      flag: json['flag'] ?? false,
    );
  }
}
