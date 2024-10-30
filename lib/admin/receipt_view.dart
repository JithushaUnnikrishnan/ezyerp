import 'package:bill/models/receiptModel.dart';
import 'package:bill/service/receiptservice.dart';
import 'package:flutter/material.dart';

class ViewReceipt extends StatefulWidget {
  const ViewReceipt({super.key});

  @override
  State<ViewReceipt> createState() => _ViewReceiptState();
}

class _ViewReceiptState extends State<ViewReceipt> {
  late Future<List<Collections>> _receiptsFuture;

  @override
  void initState() {
    super.initState();
    _receiptsFuture = ReceiptService().fetchReceipts();
    print(_receiptsFuture);
  }

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text('Receipts', style: TextStyle(color: Colors.white,fontSize: textScaleFactor*16)),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<List<Collections>>(
        future: _receiptsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading receipts'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No receipts available'));
          }

          final receipts = snapshot.data!;
          print(receipts.toList());
          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              print(receipt);
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
                color: Colors.white,
                child: ListTile(
                  title: Text(receipt.customerName ?? 'No Name',style: TextStyle(fontSize:textScaleFactor*12,fontWeight: FontWeight.bold ),),
                  subtitle: Text(receipt.payment ?? 'No Payment Info',style: TextStyle(color: Colors.blue.shade800,fontWeight: FontWeight.w700),),
                  trailing: Text(receipt.rdate ?? 'No Date',),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
