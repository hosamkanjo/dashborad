import 'package:dashboard/main.dart';
import 'package:dio/dio.dart';
// http://137.184.50.2/
class DashboardService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchDashboardData() async {
    const apiUrl = 'http://137.184.50.2/api/v1/dashboard/home';
      final token = storage.getString('token');
    try {
      final response = await _dio.get
      
      (apiUrl
      ,
        options: Options(
          headers: {
              'Authorization': 'Bearer $token', 
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )    
      
      );

      print(' Response Status: ${response.statusCode}');
      print(' Response Data: ${response.data}');
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception('Failed to load data: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
