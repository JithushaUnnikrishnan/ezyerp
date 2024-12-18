import 'package:bill/models/dashboard.dart';
import 'package:bill/service/dashboardService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bill/responsive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc; // Prefix for location package
import 'package:geocoding/geocoding.dart' as geo; // Prefix for geocoding package
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> Userdashboardd = [];
  late Future<List<Map<String, dynamic>>> futureDashboardData;
  String? officeName;
  String? locations;
  String? adminname;
  String subLocality = '';
String locality = '';
String administrativeArea = '';
  //  DateTimeRange? selectedDateRange;
    DateTimeRange selectedDateRange = DateTimeRange(
      
    start: DateTime(DateTime.now().year, DateTime.now().month, 1,),
    end: DateTime.now(),
  );
     loc.Location location = loc.Location();
  String currentLocation = "...";
 // String currentLocation = "Fetching location...";
   
 Future<void> _getLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check for permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    // Get the current location
    locationData = await location.getLocation();

    // Convert latitude and longitude to a readable address
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      geo.Placemark place = placemarks[0];

      setState(() {
        
        currentLocation = " ${place.locality}, ${place.administrativeArea}";
         subLocality = place.subLocality ?? 'Unknown SubLocality';
      });
    } catch (e) {
      setState(() {
        currentLocation = "Unable to get location name";
        subLocality="";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureDashboardData = fetchDashboard();
    print("FUTUREDASHBOARD DATA IS $futureDashboardData");
    getOfficeName();
     _getLocation();
  }

  Future<void> getOfficeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('officeName') ?? 'Default Office Name';
    prefs.getString("location") ?? 'Default Location';
    prefs.getString('Adminname') ?? 'Default admin Name';
    adminname=prefs.getString('Adminname') ?? 'Default admin Name';
    locations = (prefs.getString("location") ?? 'Default Location');
    officeName = prefs.getString('officeName') ?? 'Default Office Name';


    // Update the state with the retrieved office name
// Default value if not found
  }

  // Future<List<Map<String, dynamic>>> FetchDashboard() async {
  //   // Fetch customer data and update the state
  //   List<Map<String, dynamic>> data = await Dashboardapi(); // Add await here
  //   print("data is $data");
  //   return data;
  //   // setState(() {
  //   //   Userdashboardd = data;

  //   //   print("data iss $Userdashboardd");
  //   // });
  // }
 Future<List<Map<String, dynamic>>> fetchDashboard() async {
    return await Dashboardapi(
      
      sdate: selectedDateRange.start,
      edate: selectedDateRange.end,
    );
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
        futureDashboardData = fetchDashboard();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [Colors.indigo];

    final List<String> gridItems = [
      "sale",
      "Purchase",
      "Receipt",
      "Payment",
      "Quotation",
      "Settings"
    ];
    final List<IconData> gridIcons = [
      Icons.sell_outlined,
       Icons.add_shopping_cart,
 Icons.receipt_long_outlined,
      Icons.payment,
     Icons.note_outlined,
      Icons.settings

     
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;

    print('kk +$screenWidth');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        title: Row(
          children: [
            Icon(
              CupertinoIcons.location_solid,
              color: Colors.white,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(subLocality, style: TextStyle(
                    color: Colors.white,
                    fontSize: textScaleFactor * 13),),
              Text(
                currentLocation,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: textScaleFactor * 13),
              ),
              
            ],
          ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: futureDashboardData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while fetching data
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Display error message if data fetching fails
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Show a message if no data is found
              return Center(child: Text("No data available"));
            }

            // If data is fetched successfully, display the content
            List<Map<String, dynamic>> userDashboardData = snapshot.data!;
            final String collectionAmt = userDashboardData[0]["collectionamt"] ?? '0';
    final String collectionCnt = userDashboardData[0]["collectioncnt"] ?? '0';
    print("jiyhh$collectionCnt");

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: isLandscape
                            ? screenHeight * 0.25
                            : Responsive.isSmallScreen(context)
                                ? screenHeight * 0.16
                                : Responsive.isMediumScreen(context)
                                    ? screenHeight * 0.19
                                    : screenHeight * 0.17,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff524de5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.001,
                                  ),
                                  Row(
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          "Hi,",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontSize: textScaleFactor *
                                                  13), // Adjust font size
                                        ),
                                      ),
                                       FittedBox(
                                        child: Text(
                                          
                                          adminname.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700, color: Colors.white,
                                              fontSize: textScaleFactor *13)))
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      officeName.toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textScaleFactor *
                                              11, // Adjust font size
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      locations.toString().toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textScaleFactor * 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Container(
                                height: isLandscape
                                    ? screenHeight * 0.3
                                    : Responsive.isSmallScreen(context)
                                        ? screenHeight * 0.12
                                        : Responsive.isMediumScreen(context)
                                            ? screenHeight * 0.19
                                            : screenHeight * 0.17,
                                width: isLandscape
                                    ? screenWidth * 0.12
                                    : Responsive.isSmallScreen(context)
                                        ? screenWidth * 0.25
                                        : Responsive.isMediumScreen(context)
                                            ? screenWidth * 0.1
                                            : screenWidth * 0.07,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/home1.png"),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),

                    Container(
                      height: isLandscape
                          ? screenHeight * 0.085
                          : screenHeight * 0.05,
                      width: screenWidth * .95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1.6, color: Color(0xff171457)),
                      ),
                      child: InkWell(onTap: _pickDateRange ,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                             Icon(
                              CupertinoIcons.calendar,
                              size: 15,
                              color: Color(0xff783d8f),
                            ),
        
                          Text(
                           
                            "${DateFormat('dd/MM/yyyy').format(selectedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(selectedDateRange.end)}",
                               
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                                            ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .01,
                    ),

                    // Collection Container
                    SizedBox(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: isLandscape
                            ? screenHeight * 0.22
                            : Responsive.isSmallScreen(context)
                                ? screenHeight * 0.123
                                : Responsive.isMediumScreen(context)
                                    ? screenHeight * 0.13
                                    : screenHeight * 0.13,
                        width: screenWidth * .95,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                spreadRadius: 1.5,
                                color: Colors.grey.shade200,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 233, 162, 203),
                                  const Color.fromARGB(255, 255, 255, 255)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Collection",
                                  style: TextStyle(
                                      fontSize: textScaleFactor *
                                          14), // Adjust font size
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.currency_rupee,
                                        size: 15, color: Colors.black),
                                    Text(
                                      // userDashboardData[0]["collectionamt"],
                                      collectionAmt,
                                      style: TextStyle(
                                          fontSize: textScaleFactor *
                                              12, // Adjust font size
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Count:",
                                      style: TextStyle(
                                          fontSize: textScaleFactor * 12),
                                    ),
                                    Text(
                                      // userDashboardData[0]["collectioncnt"],
                                      collectionCnt,
                                      style: TextStyle(
                                          fontSize: textScaleFactor * 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              child: Container(
                                height: isLandscape
                                    ? screenHeight * 0.15
                                    : Responsive.isSmallScreen(context)
                                        ? screenHeight * 0.08
                                        : Responsive.isMediumScreen(context)
                                            ? screenHeight * 0.19
                                            : screenHeight * 0.17,
                                width: isLandscape
                                    ? screenWidth * 0.08
                                    : Responsive.isSmallScreen(context)
                                        ? screenWidth * 0.15
                                        : Responsive.isMediumScreen(context)
                                            ? screenWidth * 0.1
                                            : screenWidth * 0.07,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/bill.png"),
                                        fit: BoxFit.fill)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                          isLandscape ? screenHeight * 0.4 : screenHeight * 0.3,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Responsive.isSmallScreen(context)
                              ? 3
                              : 3, // Adjust number of columns based on screen size
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          childAspectRatio:
                              1.2, // Adjust aspect ratio as needed
                        ),
                        itemCount: gridItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(offset: Offset(0, 1),color: Colors.grey,spreadRadius: 2,blurRadius: 2)],
                                    color: Colors.indigo,borderRadius: BorderRadius.circular(10)),
                                  width: screenWidth*0.25,
                                   child: Icon(gridIcons[index],color: Colors.white,),
                                 
                                )
                              ),
                              Text(gridItems[index],style: TextStyle(color: Colors.black,fontSize: textScaleFactor*11,fontWeight: FontWeight.bold),)
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
