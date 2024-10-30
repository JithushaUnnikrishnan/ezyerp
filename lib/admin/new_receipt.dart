import 'package:bill/admin/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customers.dart';
import 'package:bill/responsive.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  DateTime? _selectedDate;
  DateTime?_select;

  String? _selectedPaymentType;
  String? _selectedReceive;
  final formkey = GlobalKey<FormState>();
  var chequedate = TextEditingController();
  var date=TextEditingController();
  var amount = TextEditingController();

  final List<String> _options = ['UPI', 'Cheque', 'Cash', 'Creditcard'];
  final List<String> _receive = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var orientation = MediaQuery.of(context).orientation;
         bool isLandscape = orientation == Orientation.landscape;

    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight:isLandscape?screenHeight*0.3: Responsive.isSmallScreen(context)
              ? screenHeight * 0.16
              : Responsive.isMediumScreen(context)
                  ? screenHeight * 0.17
                  : screenHeight * 0.2,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          flexibleSpace: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0, left: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(initialIndex: 1,)));},
                        icon: Icon(Icons.arrow_back,color: Colors.white,)),
                      Text(
                        "New Receipt",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textScaleFactor * 16,
                        ),
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                height: isLandscape?screenHeight*0.18:screenHeight * 0.1,
                color: Colors.indigo,
              ),
              Container(
                width: screenWidth,
                height:isLandscape?screenHeight*0.11: Responsive.isSmallScreen(context)
                    ? screenHeight * 0.06
                    : Responsive.isMediumScreen(context)
                        ? screenHeight * 0.06
                        : screenHeight * 0.06, // Height for the text section
                decoration: BoxDecoration(
                  color: Color(0xfff3e5f6),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the text vertically
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "4B MOTORS",
                        style: TextStyle(
                          fontSize: textScaleFactor * 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "1032",
                        style: TextStyle(
                          fontSize: textScaleFactor * 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                "Date:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: date, // Use the date controller
                      readOnly:
                          true, // Set the TextFormField to read-only to prevent manual input
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintText: _selectedDate != null
                            ? "${_select!.day}-${_select!.month}-${_select!.year}" // Display selected date
                            : "Select Date", // Default hint text when no date is selected
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? datepick = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      );
                      if (datepick != null) {
                        setState(() {
                          _select = datepick; // Store selected date
                          // Update the controller with the selected date
                          date.text =
                              "${datepick.day}-${datepick.month}-${datepick.year}";
                        });
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      size:isLandscape?screenHeight*0.09: MediaQuery.of(context).size.height * .03,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "Received to:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                ),
                value: _selectedReceive, // Currently selected value
                items: _receive.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedReceive = newValue; // Update the selected value
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "Amount:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: amount,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty amount';
                  }
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "PaymentType:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                ),
                value: _selectedPaymentType,
                items: _options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPaymentType = newValue;
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "Cheque No:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder()),
              ),
               SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                "Cheque Date:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
             
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: chequedate, // Use the date controller
                      readOnly:
                          true, // Set the TextFormField to read-only to prevent manual input
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                        hintText: _selectedDate != null
                            ? "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}" // Display selected date
                            : "Select Date", // Default hint text when no date is selected
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? datepick = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      );
                      if (datepick != null) {
                        setState(() {
                          _selectedDate = datepick; // Store selected date
                          // Update the controller with the selected date
                          chequedate.text =
                              "${datepick.day}-${datepick.month}-${datepick.year}";
                        });
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      size:isLandscape?screenHeight*0.09: MediaQuery.of(context).size.height * .03,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                "Remarks:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              InkWell(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigation(
                                  initialIndex: 1,
                                )));
                  }
                },
                child: Container(
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                  height:isLandscape?screenHeight*0.1: Responsive.isSmallScreen(context)
                      ? screenHeight * 0.06
                      : Responsive.isMediumScreen(context)
                          ? screenHeight * 0.06
                          : screenHeight * 0.06,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff9c28b1)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
