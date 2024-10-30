import 'package:bill/service/statement_service.dart';
import 'package:flutter/material.dart';

class StatementsLists extends StatefulWidget {
  const StatementsLists({super.key});

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
    return Scaffold(
       appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Statements",
          style: TextStyle(
            color: Colors.white,
            fontSize: textScaleFactor * 16,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: statements.length,
        itemBuilder: (context, index) {
          var statement = statements[index];
        return Card(
          color: Colors.white,
          elevation: 4,
        child: ListTile(trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Text(statement["expout"],style: TextStyle(color: Colors.red),),
          Text(statement["incout1"]),
          Text(statement["expin"]),
         

        ],),
        title: Text(statement["invoice"],style: TextStyle(fontSize: textScaleFactor*12,fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(statement["pinvtype"],),
          Text(statement["pur_date"]),
          
        ],),
        ),
      );
      },)
    );
  }
}