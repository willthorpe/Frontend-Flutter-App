import 'package:flutter_app/globals.dart';
import 'package:http/http.dart' as http;

Future <String> deleteIngredient(String name) async {
  var response = await http.delete(url + "/ingredient?user=" + user.uid + "&ingredient=" + name);
  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future <String> deleteRecipe(String name) async {
  var response = await http.delete(url + "/recipe?user=" + user.uid + "&recipe=" + name);
  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}