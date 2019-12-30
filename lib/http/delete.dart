import '../globals.dart';
import 'package:http/http.dart' as http;

Future <String> deleteRecipe(String name) async {
  var response = await http.patch(url + "/recipe", body: {
    'user': user.uid,
    'name': name,
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}