import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<Map<String, dynamic>>> CustomerList() async {
  Map<String, dynamic> data = {
    "officeid": "1",
    "officecode": "RD01",
    "financialyearid": "1"
  };

  const headercommon = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  try {
    var response = await http.post(
      Uri.parse("http://app.ezyerp.live/customerlist.php"),
      headers: headercommon,
      body: Uri(queryParameters: data).query,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['flag'] == true) {
        // Return the list of customers
        print("response customer ${response.body}");
        return List<Map<String, dynamic>>.from(jsonResponse['customers']);  
        // customers api le list nte per 
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('An error occurred: $e');
  }

  // Return an empty list if an error occurred
  return [];
}
