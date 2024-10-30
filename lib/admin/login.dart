import 'dart:convert';
import 'package:bill/admin/counter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:bill/common/api_connect.dart';
import 'package:bill/custom/button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';

import '../custom/textformfeild.dart';
import 'bottomnavigation.dart';
import 'home.dart';
import 'package:bill/responsive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Adlogin() {
  //   if (username.text == 'admin' &&
  //       password.text == '1234' &&
  //       officecode.text == "101010") {
  //     return Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => BottomNavigation(initialIndex: 0,)));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Invalid Username or Password or Officecode")));
  //   }
  // }

  final formkey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var officecode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
        double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Form(
      key: formkey,
      child: Scaffold(
        backgroundColor:Color(0xfffffbff),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: screenHeight * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      
                      height: screenHeight*0.03,
                      width: screenWidth*0.3,
                      decoration: BoxDecoration( image: DecorationImage(image: AssetImage('assets/erp.png'))),),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .15,
                ),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Container(
                    //  height: screenHeight * 0.5,
                   width: Responsive.isSmallScreen(context)
                      ? screenWidth *.90
                        : Responsive.isMediumScreen(context)
                        ? screenWidth * 0.45 // Tablet
                        : screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                     boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 9),
                            color: Colors.grey.shade300,
                            spreadRadius: 4,
                            blurRadius: 9)
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * .04,
                          ),
                          Text(
                            "Login",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: textScaleFactor * 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: screenHeight * .015,
                          ),
                          CustomTextformfield(
                            controller: officecode,
                            hintText: "Office code",
                            PrefixIcon:Icons.compare_arrows_rounded
                          ),
                          SizedBox(
                            height: screenHeight * .015,
                          ),
                          CustomTextformfield(
                            controller: username,
                            hintText: "Username",
                            PrefixIcon: Icons.person_outlined,
                          ),
                          SizedBox(
                            height: screenHeight * .015,
                          ),
                          CustomTextformfield(
                            controller: password,
                            hintText: "Password",
                            PrefixIcon: Icons.lock_outlined,
                          ),
                          SizedBox(
                            height: screenHeight * .015,
                          ),
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Color(0xff6e35a9),
                              fontWeight: FontWeight.w500,
                              fontSize: textScaleFactor * 11,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * .025,
                          ),
                          Center(
                            child: CustomButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  // Adlogin();
                                  Loginn(
                                      username: username.text,
                                      password: password.text,
                                      officecode: officecode.text);
                                  print("user" + username.text);
                                  print("pass" + password.text);
                                  print("office" + officecode.text);
                                }
                              },
                              color: Colors.indigo,
                              text: "LOGIN",
                              TextColor: Colors.white,
                            ),
                          ),SizedBox(
                            height: Responsive.isSmallScreen(context)
                                ? screenHeight * 0.03
                                : Responsive.isMediumScreen(context)
                                    ? screenHeight * 0.01
                                    : screenHeight * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Responsive.isSmallScreen(context)
                      ? screenHeight * 0.19
                      : Responsive.isMediumScreen(context)
                          ? screenHeight * 0.19
                          : screenHeight * 0.17,
                ),
                Text(
                  "Powered By",
                  style: TextStyle(fontSize: textScaleFactor * 10,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/ecraft.png"))),
                    ),
                    Text(
                      "Ecraftz",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> Loginn() async {
  //   // The data you are sending to the API
  //   Map<String, dynamic> data = {
  //     "username": "admin",
  //     "password": "admin",
  //     "officecode": "RD01"
  //   };
  //
  //   try {
  //     // Sending the POST request
  //     var response = await postJson("/login.php", data);
  //
  //     // Printing the response for debugging
  //     print("Response: $response");
  //
  //     if (response.statusCode == 200) {
  //       // Success: Handle the response
  //       print('Success: ${response.body}');
  //     } else {
  //       // Error: Handle the error response
  //       print('Error: ${response.statusCode}, ${response.body}');
  //     }
  //   } catch (e) {
  //     // Catch and print any exceptions that occur during the request
  //     print('An error occurred: $e');
  //   }
  // }

// Function to make the POST request

  Future<void> Loginn({
    required String username,
    required String password,
    required String officecode,
  }) async {
    Map<String, dynamic> data = {
      "username": username,
      "password": password,
      "officecode": officecode,
    };
    const headercommon = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };
    try {
      //var response = await postJson("/login.php", data);
      var responses = await http.post(
          Uri.parse("http://app.ezyerp.live/login.php"),
          headers: headercommon,
          body: Uri(queryParameters: data).query);
      print(responses.body);

      if (responses.statusCode == 200) {
      // Decode the JSON response
      var jsonResponse = json.decode(responses.body);
      
      // Check if the login was successful based on the 'flag'
      if (jsonResponse['flag'] == true) {
        print('Login successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Counter()),
        );
      } else {
        // Handle the unsuccessful login case
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse['msg'] ?? "Login failed"),
        ));
        print('Login failed: ${jsonResponse['msg']}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Username or Password or Officecode"),
      ));
      print('Login failed with status code: ${responses.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }}
}
