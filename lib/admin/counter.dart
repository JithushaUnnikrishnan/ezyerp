import 'package:bill/admin/bottomnavigation.dart';
import 'package:bill/counterclass.dart';
import 'package:bill/custom/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert'; // Import for JSON decoding
import 'package:bill/responsive.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final formkey=GlobalKey<FormState>();
  List<CounterItem> _office = [];
  List<String> _year = []; // Use an empty list for dynamic years
  String? _Selectyear;
  CounterItem? _selectedOffice; // Change to CounterItem type

  @override
  void initState() {
    super.initState();
    Financial();
    CounterListt(); // Fetch financial years and counter list on initialization
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(key: formkey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Responsive.isSmallScreen(context)
                    ? screenHeight * 0.3
                    : screenHeight * .9,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * .01),
                    Text("Select Counter"),
                    DropdownButtonFormField<CounterItem>(validator:(value){if(value==null){return "Required this feild";}else{return null;}},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedOffice, // Currently selected value
                      items: _office.map((CounterItem counter) {
                        return DropdownMenuItem<CounterItem>(
                          value: counter,
                          child: Text('${counter.name} '), // Display name and ID
                        );
                      }).toList(),
                      onChanged: (CounterItem? newValue) {
                        setState(() {
                          _selectedOffice = newValue; // Update the selected value
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * .02),
                    Text("Financial Year"),
                    DropdownButtonFormField<String>(validator: (value){if(value==null){return "Required this feild";}else{null;}},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: _Selectyear, // Currently selected value
                      items: _year.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _Selectyear = newValue; // Update the selected value
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * .03),
                    CustomButton(
                        color: Colors.indigo,
                        text: "Choose",
                        TextColor: Colors.white,
                        onPressed: () {
                          if(formkey.currentState!.validate())
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigation(initialIndex: 0)));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Financial() async {
    Map<String, dynamic> data = {
      "officecode": 'RD01',
      "officeid": "1",
      "employeeid": "1",
      "usertypeid": '1',
    };

    const headercommon = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    try {
      var responses = await http.post(
        Uri.parse("http://app.ezyerp.live/financialyears.php"),
        headers: headercommon,
        body: Uri(queryParameters: data).query,
      );

      print('Response body: ${responses.body}');

      if (responses.statusCode == 200) {
        var jsonResponse = json.decode(responses.body);

        if (jsonResponse['flag'] == true &&
            jsonResponse.containsKey('financial_years')) {
          List<String> fetchedYears = (jsonResponse['financial_years'] as List)
              .map((yearObj) => yearObj['financial_year'] as String)
              .toList();

          setState(() {
            _year =
                fetchedYears; // Update the year dropdown options dynamically
          });

          print('Financial years fetched successfully: $fetchedYears');
        } else {
          print(
              'No financial years found or flag is false: ${jsonResponse['msg']}');
        }
      } else {
        print('Financial request failed: ${responses.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // Counter
  Future<void> CounterListt() async {
    Map<String, dynamic> data = {
      "officecode": 'RD01',
      "officeid": "1",
      "employeeid": "1",
      "usertypeid": '1',
    };

    const headercommon = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    try {
      var responses = await http.post(
        Uri.parse("http://app.ezyerp.live/counterlist.php"),
        headers: headercommon,
        body: Uri(queryParameters: data).query,
      );

      print('Response body: ${responses.body}');

      if (responses.statusCode == 200) {
        var jsonResponse = json.decode(responses.body);

        if (jsonResponse['flag'] == true &&
            jsonResponse.containsKey('counters')) {
          List<CounterItem> fetchedCounters = (jsonResponse['counters'] as List)
              .map((countObj) => CounterItem(
                    id: countObj['counter_id'] as String,
                    name: countObj['counter_name'] as String,
                  ))
              .toList();

          setState(() {
            _office = fetchedCounters; // Store fetched counters
            _selectedOffice = null; // Reset selected value
          });

          print('Counters fetched successfully: $fetchedCounters');
        } else {
          print('No counters found or flag is false: ${jsonResponse['msg']}');
        }
      } else {
        print('Counter request failed: ${responses.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
