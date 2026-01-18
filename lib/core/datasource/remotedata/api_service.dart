import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remotedata/api_config.dart';

abstract class BaseApiService {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params});
}

class ApiService extends BaseApiService {
  // ApiService._();
  // static final ApiService _instance = ApiService._();
  // factory ApiService() => _instance;

  @override
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    var url = Uri.http(ApiConfig.baseUrl, 'v2/$endpoint', {
      'apiKey': ApiConfig.apiKey,
      ...?params,
    });
    print(url);
    try {
      final response = await http.get(url);
      return jsonDecode(response.body);
    } on Exception catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
