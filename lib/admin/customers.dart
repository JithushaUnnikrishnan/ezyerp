import 'package:bill/admin/statement.dart';
import 'package:bill/service/customer_listService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bill/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'credit_aging.dart';
import 'new_receipt.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  List<Map<String, dynamic>> customers = [];
  List<Map<String, dynamic>> search = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCustomerData();
    searchController.addListener(_filterCustomers);
  }

  Future<void> fetchCustomerData() async {
    List<Map<String, dynamic>> data = await CustomerList();
    setState(() {
      customers = data;
      search = data;
      isLoading = false;
      print("data is $customers");
    });
  }

  void _filterCustomers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      search = customers
          .where((customer) =>
              customer["customer_name"]?.toLowerCase().contains(query) ?? false)
          .toList();
    });
  }

//   void showCallDialog(BuildContext context, Map<String, dynamic> customer) {
//   final whatsapp = customer["whatsappno"];
//   int number = int.parse(whatsapp);
  
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Choose number"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Display the WhatsApp number
//             // Text("$number",
//             //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             // ),
//             SizedBox(height: 8),
//             InkWell(
//               onTap: () async {
                
//                 await launch("https://wa.me/$number?text=Hello");
//               },
//               child: Row(
               
//                 children: [
//                   Icon(
//                     CupertinoIcons.phone_circle,
//                     size: 20,
//                     color: Colors.black,
//                   ),
//                   SizedBox(width: 8),
//                   Text("$number"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

void showCallDialog(BuildContext context, Map<String, dynamic> customer) {
  final whatsapp = customer["whatsappno"];
  
  
  List<String> numbers = (whatsapp != null && whatsapp.isNotEmpty) 
      ? whatsapp.split('/') // Split by '/' or adjust to your delimiter
      : [];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Choose number"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (numbers.isEmpty)
              Text(
                "No WhatsApp number",
                style: TextStyle(fontSize: 16, ),
              )
            else
              // Display each number in a separate row
              ...numbers.map((number) {
                return InkWell(
                  onTap: () async {
                    await launch("https://wa.me/${number.trim()}?text=Hello");
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.phone_circle,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(number.trim()), // Trim any extra spaces
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
       
      );
    },
  );
}
void showPhoneDialog(BuildContext context, Map<String, dynamic> customer) {
  final phoneNumbers = customer["mobileno"];
  
  // Split the phone numbers by '/' or another delimiter if multiple numbers are present
  List<String> numbers = (phoneNumbers != null && phoneNumbers.isNotEmpty) 
      ? phoneNumbers.split('/') 
      : [];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Choose number"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (numbers.isEmpty)
              Text(
                "No phone number available",
                style: TextStyle(fontSize: 16,),
              )
            else
              // Display each number in a separate row
              ...numbers.map((number) {
                return InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse('tel:${number.trim()}');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(number.trim()), // Trim any extra spaces
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
       
      );
    },
  );
}


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        automaticallyImplyLeading: false,
        title: Text(
          "Customers",
          style: TextStyle(
            color: Colors.white,
            fontSize: textScaleFactor * 16,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: isLandscape
                      ? screenHeight * 0.08
                      : Responsive.isSmallScreen(context)
                          ? screenHeight * 0.05
                          : Responsive.isMediumScreen(context)
                              ? screenHeight * .04
                              : screenHeight * 0.05,
                  width: screenWidth * 0.83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: const Color.fromARGB(255, 32, 4, 70)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.search,
                            color: Colors.grey), // Search icon
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here...",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: textScaleFactor * 15)),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.filter_alt_outlined,
                  size: 40,
                  color: Colors.black54,
                )
              ],
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(), // Loading spinner
                    )
                  : search.isEmpty
                      ? Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(
                              fontSize: textScaleFactor * 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: search.length,
                          itemBuilder: (context, index) {
                            var customer = search[index];
                            return Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: isLandscape
                                          ? screenHeight * 0.035
                                          : screenHeight * 0.02,
                                      width: isLandscape
                                          ? screenWidth * 0.22
                                          : screenWidth * 0.37,
                                      child: Text(
                                        customer["customer_name"]
                                                ?.toUpperCase() ??
                                            "",
                                        style: TextStyle(
                                          fontSize: textScaleFactor *
                                              10, // Adjust text size
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                        height: isLandscape
                                            ? screenHeight * 0.031
                                            : screenHeight * 0.02,
                                        width: screenWidth * 0.21,
                                        child: Text(
                                          customer["area_name"]
                                                  ?.toUpperCase() ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ],
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Get the phone numbers and split them by '/' if multiple numbers are present

                                    InkWell(
                                      onTap: () async {
                                        showPhoneDialog(context, customer);
                                        // final phoneNumber =
                                        //     customer["mobileno"];
                                        // final Uri url =
                                        //     Uri.parse('tel:$phoneNumber');
                                        // if (await canLaunchUrl(url)) {
                                        //   await launchUrl(url);
                                        // } else {
                                        //   throw 'Could not launch $url';
                                        // }
                                      },
                                      child: Icon(
                                        Icons.phone_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    InkWell(
                                      onTap: () {

                                        showCallDialog(context, customer);
                                      },
                                      child: Icon(
                                        CupertinoIcons.phone_circle,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      size: 15,
                                      color: customer["currbalance"] == '0.00'
                                          ? Colors.black
                                          : Color.fromARGB(255, 32, 122, 35),
                                    ),
                                    Text(
                                      customer["currbalance"],
                                      style: TextStyle(
                                        fontSize: textScaleFactor * 10,
                                        fontWeight: FontWeight.bold,
                                        color: customer["currbalance"] == '0.00'
                                            ? Colors.black
                                            : Color.fromARGB(255, 32, 122, 35),
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        switch (value) {
                                          case 'credit age':
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreditAging()));
                                            break;
                                          case 'receipt':
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Receipt()));
                                            break;
                                          case 'statement':
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StatementsLists(customerName: customer["customer_name"],
                                                        place: customer["area_name"],
                                                        )));

                                            break;
                                        }
                                        print("Selected: $value");
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            value: 'Location',
                                            child: Row(
                                              children: [
                                                Icon(CupertinoIcons.placemark),
                                                Text('Location'),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'statement',
                                            child: Row(
                                              children: [
                                                Icon(Icons.receipt),
                                                Text('Statement'),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'credit age',
                                            child: Row(
                                              children: [
                                                Icon(Icons.credit_score),
                                                Text('Credit Age Report'),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'receipt',
                                            child: Row(
                                              children: [
                                                Icon(Icons
                                                    .receipt_long_outlined),
                                                Text('Receipt'),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}
