import 'package:bill/models/crediaging.dart';
import 'package:bill/service/creditaging_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bill/responsive.dart';

class CreditAging extends StatefulWidget {
  const CreditAging({super.key});

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
    fetchcredit();
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
            Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.white)
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
            child:credits.isNotEmpty? Row(
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
                       credits[0]["customer_name"].toUpperCase(),
                        style: TextStyle(
                          fontSize: textScaleFactor * 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        credits[0]["address"],
                        style: TextStyle(fontSize: textScaleFactor * 10),
                      ),
                    ),
                  ],
                ),
                Icon(CupertinoIcons.arrow_2_circlepath)
              ],
            )
             : Center(
          child: Text(
            'No data available',
            style: TextStyle(fontSize: textScaleFactor * 12),
          ),
        
),
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
                            Column(
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
                            Column(
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
                            Column(
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 10,
                                      color: Colors.green,
                                    ),
                                    Text(
                                       credit["balamt"],
                                      style: TextStyle(
                                          fontSize: textScaleFactor * 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
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
            'No data available',
            style: TextStyle(fontSize: textScaleFactor * 12),
          ),
        
),
      ),
    );
  }
}

// api part of credit aging

