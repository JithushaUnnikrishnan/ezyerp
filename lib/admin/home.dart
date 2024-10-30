import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bill/responsive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
        var orientation = MediaQuery.of(context).orientation;
         bool isLandscape = orientation == Orientation.landscape;

    print('kk +$screenWidth');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(        automaticallyImplyLeading: false,

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
                Text(
                  "Panniyankara",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: textScaleFactor * 16), // Adjust based on text scale
                ),
                Text(
                  "Kozhikode, Kerala",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: textScaleFactor * 14),
                )
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  height: isLandscape
                      ? screenHeight * 0.25 :Responsive.isSmallScreen(context)
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
                            FittedBox(
                              child: Text(
                                "Hi, Admin",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: textScaleFactor * 16),  // Adjust font size
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            FittedBox(
                              child: Text(
                                "ROYAL AUTO DISTRIBUTORS PVT LTD".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textScaleFactor * 12,  // Adjust font size
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "Palazhi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textScaleFactor * 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Container(
                           height:isLandscape?screenHeight*0.3:Responsive.isSmallScreen(context)
                      ? screenHeight * 0.12
                      : Responsive.isMediumScreen(context)
                          ? screenHeight * 0.19
                          : screenHeight * 0.17,
                          width:isLandscape?screenWidth*0.12: Responsive.isSmallScreen(context)
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
        
             
              Container(
                height:isLandscape?screenHeight*0.085: screenHeight * 0.05,
                width: screenWidth * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.6, color: Color(0xff171457)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.calendar,
                          size: 15,
                          color: Color(0xff783d8f),
                        )),
                    Text(
                      "01/02/2024 -",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      " 08/02/2024",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
        
              // Collection Container
              SizedBox(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height:isLandscape?screenHeight*0.22: Responsive.isSmallScreen(context)
                      ? screenHeight * 0.123
                      : Responsive.isMediumScreen(context)
                          ? screenHeight * 0.13
                          : screenHeight * 0.13 ,
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
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 233, 162, 203),
                        const Color.fromARGB(255, 255, 255, 255)
                      ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Collection",
                            style: TextStyle(
                                fontSize: textScaleFactor * 14),  // Adjust font size
                          ),
                          Row(
                            children: [
                              Icon(Icons.currency_rupee,
                                  size: 15, color: Colors.black),
                              Text(
                                "0.00",
                                style: TextStyle(
                                    fontSize: textScaleFactor * 12,  // Adjust font size
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            "Count: 0",
                            style: TextStyle(fontSize: textScaleFactor * 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Container(
                          height:isLandscape?screenHeight*0.15:Responsive.isSmallScreen(context)
                      ? screenHeight * 0.08
                      : Responsive.isMediumScreen(context)
                          ? screenHeight * 0.19
                          : screenHeight * 0.17,
                          width:isLandscape?screenWidth*0.08: Responsive.isSmallScreen(context)
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
            ],
          ),
        ),
      ),
    );
  }
}
