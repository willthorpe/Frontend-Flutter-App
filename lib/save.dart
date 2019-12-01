import 'package:flutter_app/globals.dart';
import 'package:http/http.dart' as http;
String url = "http://127.0.0.1:3000";

Future <String> saveIngredient(String name, String amount, String type, String location, DateTime useByDate) async {
  var response = await http.post(url + "/ingredient", body: {
    'user': user,
    'name': name,
    'amount': amount,
    'type' : type,
    'location': location,
    'useBy' : useByDate
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}
