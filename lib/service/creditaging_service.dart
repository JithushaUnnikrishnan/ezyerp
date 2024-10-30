import 'dart:convert';
import 'package:http/http.dart' as http;




  Future<List<Map<String, dynamic>>>fetchCreditAgingData() async {
    final Map<String, dynamic> data = {
      "officecode": 'RD01',
      "officeid": "1",
      "customerid": "120",
      "financialyearid": '1',
      "noofdays":'',
      "condition":''
    };
print("data is $data");
 const headercommon = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
    try {
      var response = await http.post(
      Uri.parse("http://app.ezyerp.live/creditagingreport.php"),
      headers: headercommon,
      body: Uri(queryParameters: data).query,
    );
      // print("response of credit aging $response");
      print('response creditt ${response.body}');

      if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['flag'] == true) {
        print("response credit ${response.body}");
        return List<Map<String, dynamic>>.from(jsonResponse['creditage']);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('Error occurred: $e');
   
    // throw e;
  }
   return [];
  }