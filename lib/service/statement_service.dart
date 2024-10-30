import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<Map<String, dynamic>>> StatementList() async{
  Map<String,dynamic>data={
"officecode":"RD01",
"officeid":"1",
"customerid":"120",
"financialyearid":"1",
"sdate":"2023-04-01",
"edate":"2024-05-30",
  };
  const headercommon = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  try {
    var response = await http.post(
      Uri.parse("http://app.ezyerp.live/customerstatement.php"),
      headers: headercommon,
      body: Uri(queryParameters: data).query,
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['flag'] == true) {
        print("response statement ${response.body}");
        return List<Map<String, dynamic>>.from(jsonResponse['statement']);
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