import 'package:dashboard/main.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _i = ApiClient._();
  factory ApiClient() => _i;
  ApiClient._();

     final token = storage.getString('token');
  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://137.184.50.2/api/v1/dashboard',
       
            headers: {
            'Authorization': 'Bearer $token', 
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
}
