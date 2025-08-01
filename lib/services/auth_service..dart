import 'package:dashboard/models/logiin_model.dart';
import 'package:dashboard/main.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String token = '';

class AuthService {
 // get storage => null;
 
  Future<bool> login({required LoginModel loginInfo}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: loginInfo.toMap(),
      );
      if (response.statusCode == 200) {
        // token = response.data['accessToken'];

        storage.setString('token', response.data['accessToken']);
        print(response.data);
        print(response.data['accessToken']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  signup() {}
  signout() {}
}
// 'https://dummyjson.com/auth/login'