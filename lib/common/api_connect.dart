import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
Future<http.Response> postJson5(Map<String, String> data) async {
  var url = Uri.parse("http://app.ezyerp.live/login.php");

  const headercommon = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',  // Corrected key and value
  };


  try {
    var response = await http.post(url,
        headers: headercommon, body: convert.json.encode(data));
    return response;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
Future<Map<String, dynamic>> postJson(String suburl, Map<String, dynamic> data) async {
  var url = Uri.http("app.ezyerp.live", suburl);

 const headercommon = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Accept': 'application/json',
};
  try {
    var response = await http.post(url, headers: headercommon, body: Uri(queryParameters: data).query);


    // Log the status and response body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return json.decode(response.body);
    // Check if response is HTML (indicating a problem)
  } catch (e) {
    print('Error occurred: $e');
    return {'error': 'Network error', 'details': e.toString()};
  }
}

// Dynamic data
Future<http.Response> postJson2(
    String suburl, Map<String, dynamic> data) async {
  var url = await Uri.http(
    "app.ezyerp.live",
    suburl,
    {'q': '{http}'},
  );

  const headercommon = {
    'Content-Type': 'application/json',
  };

  var response = await http.post(url,
      headers: headercommon, body: convert.json.encode(data));
  return response;
}
// post without body
Future<http.Response> postJson1(String suburl) async {
  var url = await Uri.http(
    "app.ezyerp.live",
    suburl,
    {'q': '{https}'},
  );
  const headercommon = {
    'Content-Type': 'application/json',
  };
  url = Uri.parse("https://api.get-ug.com$suburl");
  print(url);

  var response = await http.post(url);
  return response;
}

Future<http.Response> getJson(String suburl) async {
  var url = await Uri.https(
    "api.get-ug.com",
    suburl,
    {'q': '{https}'},
  );
  const headercommon = {
    'Content-Type': 'application/json',
  };
  url = Uri.parse("https://api.get-ug.com$suburl");

  var response = await http.get(url);
  return response;
}