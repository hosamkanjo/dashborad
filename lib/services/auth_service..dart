import 'dart:convert';
import 'package:dashboard/models/logiin_model.dart';
import 'package:dashboard/main.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


// url  local base =http://localhost:8000/
// 
class AuthService {
  // get storage => null;

  Future<bool> login({required LoginModel loginInfo}) async {
    try {
      //print("khaled");

      final response = await http.post(
        Uri.parse('http://137.184.50.2/api/v1/dashboard/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginInfo.toMap()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        storage.setString('token', data['access_token']);
        print(data);
        print(data['access_token']);
        print(data['message']);
        return true;
      } else {
        print("Login failed. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  

  signup() {}
  signout() {}

  Future logout() async {}
}
// 'https://dummyjson.com/auth/login'

/*

// http://137.184.50.2/






var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('https://37a3480c151c.ngrok-free.app/api/v1/dashboard/login'));
request.body = json.encode({
  "email": "khaled@example.com",
  "password": "password"
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}

 */
