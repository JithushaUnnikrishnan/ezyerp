import 'package:bill/responsive.dart';
import 'package:bill/service/statement_service.dart';
import 'package:flutter/material.dart';

class StatementsLists extends StatefulWidget {
  final String customerName;
  final String place;

  const StatementsLists({super.key, required this.customerName, required this. place, });

  @override
  State<StatementsLists> createState() => _StatementsListsState();
}

class _StatementsListsState extends State<StatementsLists> {
  List<Map<String, dynamic>> statements = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStatementData();
  }

  Future<void> fetchStatementData() async {
    // Fetch customer data and update the state
    List<Map<String, dynamic>> data = await StatementList(); // Add await here
    setState(() {
      statements = data;
      isLoading = false;
      print("data is $statements");
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
          actions: [Container()],
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          children: [
            Container(
              width: screenWidth,
              height: isLandscape
                  ? screenHeight * 0.17
                  : Responsive.isSmallScreen(context)
                      ? screenHeight * .08
                      : Responsive.isMediumScreen(context)
                          ? screenHeight * 0.08
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
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "05/12/2001",
                          style: TextStyle(
                            fontSize: textScaleFactor * 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.calendar_month,color: Colors.purple,size: 18,)
                      ],
                    ),
                    Divider(color: Colors.black,thickness: 0.9,),
                     Text(
                       widget.customerName.toUpperCase(),
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
                    )
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
                      borderRadius: BorderRadius.circular(0),
                    ),
                    
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.001, horizontal: 5),
                    color: Colors.white,
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(statement["invoice"],
                              style: TextStyle(
                                  fontSize: textScaleFactor * 11,
                                  fontWeight: FontWeight.bold)),
                                  Text(
                                    statement["pur_date"],
                                    style: TextStyle(
                                      fontSize: textScaleFactor * 11,
                                    ),
                                  ),
                                  Text(
                                    statement["alltypes"],
                                    style: TextStyle(
                                      fontSize: textScaleFactor * 11,color: Colors.grey,fontWeight: FontWeight.bold
                                    ),
                                  ),
                        ],
                      ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            statement["incin1"],
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: textScaleFactor * 10),
                          ),
                          Text(statement["incout"], style: TextStyle(
                                color: Colors.indigo,
                                fontSize: textScaleFactor * 10),),
                          Text(statement["ob"] ,style: TextStyle(
                                color: Colors.red,
                                fontSize: textScaleFactor * 10),),
                        ],
                      ),
                    ],)
                  );
                },
              ),
            ),
          ],
        )
        
        );
  }
}
