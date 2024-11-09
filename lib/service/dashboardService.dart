// import 'package:http/http.dart' as http;
// import 'dart:convert';
// Future<List<Map<String, dynamic>>> Dashboardapi() async{
//   Map<String,dynamic>data={
// "officecode":"RD01",
// "officeid":"1",
// "empid":"1",
// "financialyearid":"1",
// "sdate":"2024-10-01",
// "edate":"2024-10-30",
//   };
//   const headercommon = {
//     'Content-Type': 'application/x-www-form-urlencoded',
//     'Accept': 'application/json',
//   };

//   try {
//     var response = await http.post(
//       Uri.parse("http://app.ezyerp.live/userdashbord.php"),
//       headers: headercommon,
//       body: Uri(queryParameters: data).query,
//     );
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//       if (jsonResponse['flag'] == true) {
//         print("response dashboard ${response.body}");
//         return List<Map<String, dynamic>>.from(jsonResponse['userdashboard']);
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//       }
//     }
//   } catch (e) {
//     print('Error occurred: $e');

//     // throw e;
//   }
//    return [];
//   }

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

Future<List<Map<String, dynamic>>> Dashboardapi({
  required DateTime sdate,
  required DateTime edate,
 
}) async {
  Map<String, dynamic> data = {
    "officecode": "RD01",
    "officeid": "1",
    "empid": '2',
    "financialyearid": "1",
    "sdate":  DateFormat('dd-MM-yyyy').format(sdate),
      "edate": DateFormat('dd-MM-yyyy').format(edate),
    // "sdate": "2024-10-01",
    // "edate": "2024-10-30",
  };
  print(data);
  const headercommon = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  try {
    var response = await http.post(
      Uri.parse("http://app.ezyerp.live/userdashbord.php"),
      headers: headercommon,
      body: Uri(queryParameters: data).query,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['flag'] == true) {
        print("response dashboard ${response.body}");

        // Check if 'userdashboard' is a map and wrap it in a list
        var userdashboardData = jsonResponse['userdashboard'];

        // Handle different formats of 'userdashboard'
        if (userdashboardData is Map<String, dynamic>) {
          // Wrap the map in a list
          return [userdashboardData];
        } else if (userdashboardData is List) {
          // Convert list of maps if already a list
          return List<Map<String, dynamic>>.from(userdashboardData);
        } else {
          print('Unexpected data format for userdashboard.');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('Error occurred: $e');
  }

  // Return an empty list if the request fails or data is unexpected
  return [];
}
