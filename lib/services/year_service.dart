
import 'package:dashboard/models/year_model.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';


class YearService {
  final _dio = ApiClient().dio;

  Future<List<YearModel>> fetchYears() async {
    final Response res = await _dio.get('/years');
    final data = res.data;

    final list = (data['date'] ?? data['data'] ?? data['years'] ?? []) as List;

    return list.map((e) => YearModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<YearModel> createYear(YearModel payload) async {
    final Response res = await _dio.post('/years', data: payload.toCreateJson());
    final Map<String, dynamic> j = res.data is Map<String, dynamic>
        ? res.data
        : (res.data as Map).cast<String, dynamic>();

  

    return YearModel.fromJson(j);
  }
}