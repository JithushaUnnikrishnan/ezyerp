import 'package:bill/models/statementmodel2.dart';
import 'package:bill/responsive.dart';
import 'package:bill/service/statement_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class StatementsLists extends StatefulWidget {
  final String customerName;
  final String place;
  String id;

  StatementsLists(
      {super.key,
      required this.customerName,
      required this.place,
      required this.id});

  @override
  State<StatementsLists> createState() => _StatementsListsState();
}

class _StatementsListsState extends State<StatementsLists> {
  List<CustomerStatement> statements = [];
  bool isLoading = true;
 
   DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime(2023, 4, 1), 
    // DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
   
    fetchStatements();
  }

   Future<void> _pickDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
         fetchStatements();
      });
    }
  }

  Future<void> fetchStatements() async {
    Map<String, dynamic> data = {
      "officecode": "RD01",
      "officeid": "1",
      "customerid": widget.id,
      "financialyearid": "1",
      "sdate":  DateFormat('yyyy-MM-dd').format(selectedDateRange.start!),
      "edate": DateFormat('yyyy-MM-dd').format(selectedDateRange.end!),
    };
    const headercommon = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

  //   try {
  //     var response = await http.post(
  //       Uri.parse("http://app.ezyerp.live/customerstatement.php"),
  //       headers: headercommon,
  //       body: Uri(queryParameters: data).query,
  //     );
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //       if (jsonResponse['flag'] == true) {
  //         print(jsonResponse);
  //         print(widget.id);
  //         setState(() {
  //           statements = (jsonResponse['statement'] as List)
  //               .map((item) => CustomerStatement.fromJson(item))
  //               .toList();
  //           isLoading = false;
  //         });
  //       }
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //   }
  // }
 try {
      var response = await http.post(
        Uri.parse("http://app.ezyerp.live/customerstatement.php"),
        headers: headercommon,
        body: Uri(queryParameters: data).query,
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        setState(() {
          if (jsonResponse['flag'] == true && jsonResponse['statement'] != null) {
            statements = (jsonResponse['statement'] as List)
                .map((item) => CustomerStatement.fromJson(item))
                .toList();
          } else {
            statements = [];
          }
          isLoading = false;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        setState(() {
          isLoading = false;
          statements = [];
        });
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        isLoading = false;
        statements = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Customer Statements",
          style: TextStyle(
            color: Colors.white,
            fontSize: textScaleFactor * 13,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: screenWidth,
                  height: isLandscape
                      ? screenHeight * 0.17
                      : Responsive.isSmallScreen(context)
                          ? screenHeight * .12
                          : Responsive.isMediumScreen(context)
                              ? screenHeight * 0.09
                              : screenHeight * .07,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                            "${DateFormat('dd/MM/yyyy').format(selectedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(selectedDateRange.end)}",
                            style: TextStyle(
                                fontSize: textScaleFactor * 11,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_month_outlined, color: Colors.purple),
                            onPressed: () => _pickDateRange(context),
                          ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.black, thickness: 0.9),
                        Text(
                          widget.customerName,
                          style: TextStyle(
                            fontSize: textScaleFactor * 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.place,
                          style: TextStyle(
                            fontSize: textScaleFactor * 9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: statements.length,
                    itemBuilder: (context, index) {
                      var statement = statements[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.001, horizontal: 5),
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    statement.invoice.toString(),
                                    style: TextStyle(
                                      fontSize: textScaleFactor * 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    statement.purDate,
                                    style: TextStyle(
                                        fontSize: textScaleFactor * 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        statement.alltypes ?? ":0",
                                        style: TextStyle(
                                            color: Color(0xff47464b),
                                            fontSize: textScaleFactor * 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " / ",
                                        style: TextStyle(
                                            color: Color(0xff47464b),
                                            fontSize: textScaleFactor * 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        statement.pinvtype ?? ":0",
                                        style: TextStyle(
                                            color: Color(0xff47464b),
                                            fontSize: textScaleFactor * 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 12,
                                        color: Color(0xff1a661b),
                                      ),
                                      Text(
                                        statement.incin1.toString(),
                                        style: TextStyle(
                                            color: Color(0xff1a661b),
                                            fontWeight: FontWeight.bold,
                                            fontSize: textScaleFactor * 10),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 12,
                                        color: Color(0xff14135f),
                                      ),
                                      Text(
                                        statement.incout.toString(),
                                        style: TextStyle(
                                            color: Color(0xff14135f),
                                            fontWeight: FontWeight.bold,
                                            fontSize: textScaleFactor * 10),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 12,
                                        color: Color(0xffcd1513),
                                      ),
                                      Text(
                                        statement.ob.toString(),
                                        style: TextStyle(
                                            color: Color(0xffcd1513),
                                            fontSize: textScaleFactor * 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
          height: isLandscape
              ? screenHeight * 0.12
              : Responsive.isSmallScreen(context)
                  ? screenHeight * 0.06
                  : Responsive.isMediumScreen(context)
                      ? screenHeight * 0.08
                      : screenHeight * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Balance ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textScaleFactor * 15,
                  )),
              Row(
                children: [
                  Icon(
                    Icons.currency_rupee,
                    color: Colors.red,
                    size: 18,
                  ),
                  Text(
                    statements.isNotEmpty
                        ? statements.last.ob.toString()
                        : "0.0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textScaleFactor * 15,
                        color: Colors.red),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}


// import 'package:bill/responsive.dart';
// import 'package:bill/service/statement_service.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class StatementsLists extends StatefulWidget {
//   final String customerName;
//   final String place;
//   final String id;

//   StatementsLists({super.key, required this.customerName, required this. place, required this.id, });

//   @override
//   State<StatementsLists> createState() => _StatementsListsState();
// }

// class _StatementsListsState extends State<StatementsLists> {
//   List<Map<String, dynamic>> statements = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//    StatementList1(); // Call the new fetchStatements method
//   }



//   Future<List<Map<String, dynamic>>> StatementList1() async {
//     Map<String, dynamic> data = {
//       "officecode": "RD01",
//       "officeid": "1",
//       "customerid": widget.id.toString(),
//       "financialyearid": "1",
//       "sdate": "2023-04-01",
//       "edate": "2024-05-30",
//     };
//     const headercommon = {
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Accept': 'application/json',
//     };

//     try {
//       var response = await http.post(
//         Uri.parse("http://app.ezyerp.live/customerstatement.php"),
//         headers: headercommon,
//         body: Uri(queryParameters: data).query,
//       );
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         if (jsonResponse['flag'] == true) {
//           print("response statement ${response.body}");
//           return List<Map<String, dynamic>>.from(jsonResponse['statement']);
//         } else {
//           print('Request failed with status: ${response.statusCode}');
//         }
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     double textScaleFactor = MediaQuery.of(context).textScaleFactor;
//     var orientation = MediaQuery.of(context).orientation;
//     bool isLandscape = orientation == Orientation.landscape;

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 50,
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           "Customer Statements",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: textScaleFactor * 13,
//           ),
//         ),
//         backgroundColor: Colors.indigo,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Container(
//                   width: screenWidth,
//                   height: isLandscape
//                       ? screenHeight * 0.17
//                       : Responsive.isSmallScreen(context)
//                           ? screenHeight * .08
//                           : Responsive.isMediumScreen(context)
//                               ? screenHeight * 0.08
//                               : screenHeight * .06,
//                   decoration: BoxDecoration(
//                     color: Color(0xfff3e5f6),
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(0, 1),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         color: Colors.grey,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "05/12/2001",
//                               style: TextStyle(
//                                 fontSize: textScaleFactor * 9,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Icon(Icons.calendar_month, color: Colors.purple, size: 18),
//                           ],
//                         ),
//                         Divider(color: Colors.black, thickness: 0.9),
//                         Text(
//                           widget.customerName.toUpperCase(),
//                           style: TextStyle(
//                             fontSize: textScaleFactor * 9,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           widget.place,
//                           style: TextStyle(
//                             fontSize: textScaleFactor * 9,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: statements.length,
//                     itemBuilder: (context, index) {
//                       var statement = statements[index];
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         margin: EdgeInsets.symmetric(
//                             vertical: screenHeight * 0.001, horizontal: 5),
//                         color: Colors.white,
//                         elevation: 4,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('',
//                                     style: TextStyle(
//                                         fontSize: textScaleFactor * 11,
//                                         fontWeight: FontWeight.bold)),
//                                 Text(
//                                   statement["pur_date"],
//                                   style: TextStyle(
//                                     fontSize: textScaleFactor * 11,
//                                   ),
//                                 ),
//                                 Text(
//                                   statement["alltypes"],
//                                   style: TextStyle(
//                                       fontSize: textScaleFactor * 11,
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   statement["incin1"],
//                                   style: TextStyle(
//                                       color: Colors.green,
//                                       fontSize: textScaleFactor * 10),
//                                 ),
//                                 Text(
//                                   statement["incout"],
//                                   style: TextStyle(
//                                       color: Colors.indigo,
//                                       fontSize: textScaleFactor * 10),
//                                 ),
//                                 Text(
//                                   statement["ob"],
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontSize: textScaleFactor * 10),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }



// //   Future<List<Map<String, dynamic>>> StatementList1() async{
// //   Map<String,dynamic>data={
// // "officecode":"RD01",
// // "officeid":"1",
// // "customerid":widget.id.toString(),
// // "financialyearid":"1",
// // "sdate":"2023-04-01",
// // "edate":"2024-05-30",
// //   };
// //   const headercommon = {
// //     'Content-Type': 'application/x-www-form-urlencoded',
// //     'Accept': 'application/json',
// //   };

// //   try {
// //     var response = await http.post(
// //       Uri.parse("http://app.ezyerp.live/customerstatement.php"),
// //       headers: headercommon,
// //       body: Uri(queryParameters: data).query,
// //     );
// //     if (response.statusCode == 200) {
// //       var jsonResponse = json.decode(response.body);
// //       if (jsonResponse['flag'] == true) {
// //         print("response statement ${response.body}");
// //         return List<Map<String, dynamic>>.from(jsonResponse['statement']);
// //       } else {
// //         print('Request failed with status: ${response.statusCode}');
// //       }
// //     }
// //   } catch (e) {
// //     print('Error occurred: $e');
   
// //     // throw e;
// //   }
// //    return [];
// //   }
// // }
