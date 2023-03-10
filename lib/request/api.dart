import 'http.dart';

/// 接口请求
class ApiService {
  ApiService._internal();

  factory ApiService() => _instance;

  static final ApiService _instance = ApiService._internal();

  /// 登录
  login(data) async {
    return await Http().post('/api/jwt/login', data: data);
  }
}
