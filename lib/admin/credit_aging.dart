import 'package:bill/models/crediaging.dart';
import 'package:bill/service/creditaging_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bill/responsive.dart';
 import 'dart:convert';
import 'package:http/http.dart' as http;

class CreditAging extends StatefulWidget {
  final String customerName;
  final String id;
  final String place;
  CreditAging({super.key, required this. customerName, required this. place, required this. id,  });

  @override
  State<CreditAging> createState() => _CreditAgingState();
}

class _CreditAgingState extends State<CreditAging> {
      List<Map<String, dynamic>> credits = [];
     bool  isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCreditAgingData();
    fetchcredit();
  }


 




  Future<List<Map<String, dynamic>>>fetchCreditAgingData() async {
    final Map<String, dynamic> data = {
      "officecode": 'RD01',
      "officeid": "1",
      "customerid": widget.id,
      "financialyearid": '1',
      "noofdays":'',
      "condition":''
    };
print("data is $data");
 const headercommon = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
    try {
      var response = await http.post(
      Uri.parse("http://app.ezyerp.live/creditagingreport.php"),
      headers: headercommon,
      body: Uri(queryParameters: data).query,
    );
      // print("response of credit aging $response");
      print('response creditt ${response.body}');

      if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['flag'] == true) {
        print("response credit ${response.body}");
        return List<Map<String, dynamic>>.from(jsonResponse['creditage']);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('Error occurred: $e');
   
    // throw e;
  }
   return [];
  }
 Future<void> fetchcredit() async {
  // Fetch customer data and update the state
  List<Map<String, dynamic>> data = await fetchCreditAgingData(); // Add await here
  setState(() {
    credits = data;
      isLoading = false;
    print("data is $credits");
  });
}
  
double _calculateTotalBalance() {
  return credits.fold(0.0, (sum, credit) {
    // Try to parse balamt as a double; if parsing fails, use 0.0
    double balamt = double.tryParse(credit["balamt"].toString()) ?? 0.0;
    return sum + balamt;
  });
}

void _showReloadDialog() {
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // Adjust border radius
      child: Container(color: Colors.white,
        width: MediaQuery.of(context).size.width * 2, // Set custom width
        height: MediaQuery.of(context).size.height * 0.21, // Set custom height
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Message!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Do you want to reload the Report?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog without reloading
                  },
                  child: Text('No', style: TextStyle(color: const Color.fromARGB(255, 243, 37, 198))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // Add your reload logic here
                  },
                  child: Text('Yes',style: TextStyle(color: const Color.fromARGB(255, 243, 37, 198))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
}
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Credit Aging Report',
              style: TextStyle(
                  color: Colors.white, fontSize: textScaleFactor * 16),
            ),
            Icon(Icons.cloud_sync_outlined, color: Colors.white,size: 40,)
          ],
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: isLandscape
                ? screenHeight * 0.1
                : Responsive.isSmallScreen(context)
                    ? screenHeight * .06
                    : Responsive.isMediumScreen(context)
                        ? screenHeight * 0.06
                        : screenHeight * .06,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the text vertically
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                       widget.customerName.toUpperCase(),
                        style: TextStyle(
                          fontSize: textScaleFactor * 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                       widget.place,
                        style: TextStyle(fontSize: textScaleFactor * 10),
                      ),
                    ),
                  ],
                ),
               GestureDetector(
                  onTap: _showReloadDialog, // Show the reload dialog on tap
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.autorenew_outlined, size: 35, color: Colors.black87),
                  ),)
              ],
            )
             
        

          ),
         Expanded(
            child:isLoading?Center(child: CircularProgressIndicator()) :ListView.builder(
              itemCount: credits.length,
              itemBuilder: (context, index) {
                   var credit = credits[index];       

                return Card(
                  elevation: 4,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.001, horizontal: 5),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    credit["invoice"],
                                    style: TextStyle(
                                        fontSize: textScaleFactor * 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    credit["pur_date"],
                                    style: TextStyle(
                                      fontSize: textScaleFactor * 11,
                                    ),
                                  ),
                                  Text(
                                    'No.Of.Days',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: textScaleFactor * 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: textScaleFactor * 11,
                                    ),
                                  ),
                                  Text(
                                    'Balance:',
                                    style: TextStyle(
                                      fontSize: textScaleFactor * 11,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * .01),
                                  Text('       '),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 10,
                                      ),
                                      Text(
                                         credit["totalamt"],
                                        style: TextStyle(
                                            fontSize: textScaleFactor * 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 10,
                                        color: Color(0xff14135f),
                                      ),
                                      Text(
                                         credit["balamt"],
                                        style: TextStyle(
                                            fontSize: textScaleFactor * 11,
                                            fontWeight: FontWeight.bold,
                                             color: Color(0xff14135f),),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    credit["noofdays"],
                                    style: TextStyle(
                                        fontSize: textScaleFactor * 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ])),
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
        child: credits.isNotEmpty?Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Balance ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: textScaleFactor * 15,
                )),
            Text(
             _calculateTotalBalance().toStringAsFixed(2),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: textScaleFactor * 15,
                  color: Colors.red),
            ),
          ],
        )
         : Center(
          child: Text(
            'Total balance is Empty',
            style: TextStyle(fontSize: textScaleFactor * 12,color: Colors.red,fontWeight: FontWeight.bold),
          ),
        
),
      ),
    );
  }
}

// api part of credit aging

