import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:funenc_flutter_template/config/index.dart';
import 'package:funenc_flutter_template/stores/appStore.dart';
import 'package:funenc_flutter_template/utils/localStorage.dart';

/// 数据请求封装
class Http {
  static Http instance = Http._internal();

  factory Http() => instance;
  static late final Dio dio;

  CancelToken cancelToken = CancelToken();

  /*
   * config it and create
   */
  Http._internal() {
    BaseOptions options = BaseOptions();
    final AppStore appStore = AppStore();
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Config.baseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      // receiveTimeout: 5000,
      //Http请求头.
      headers: {
        //do something
        "authorization": "Bearer ${appStore.userInfo?["accessToken"]}",
        // "Content-Type": "application/json"
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: "application/json; charset=utf-8",
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    //Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      EasyLoading.show(
          status: 'loading...', maskType: EasyLoadingMaskType.black);
      // Do something before request is sent
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      // Do something with response data
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      // Do something with response error
      return handler.next(e); //continue
    }));
  }

  // 获取用户信息
  getUserInfo() async {
    return await LocalStorage.get("_USER_INFO");
  }

  /*
   * get请求
   */
  get(String url,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      var response = await dio.get(url,
          queryParameters: params, options: options, cancelToken: cancelToken);
      EasyLoading.dismiss();
      if (response.data["errcode"] != 0) {
        EasyLoading.showError(response.data["msg"]);
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      formatError(e);
    }
    return null;
  }

  /*
   * post请求
   */
  post(
    String url, {
    required data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.post(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      EasyLoading.dismiss();
      if (response.data["errcode"] != 0) {
        EasyLoading.showError(response.data["msg"]);
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print('post error---------$e');
      }
      formatError(e);
    }
    EasyLoading.dismiss();
    return null;
  }

  /*
  * put请求
  */
  put(
    String url, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    late Response response;
    try {
      response = await dio.put(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      EasyLoading.dismiss();
      if (response.data["errcode"] != 0) {
        EasyLoading.showError(response.data["msg"]);
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print('put error---------$e');
      }
      formatError(e);
    }
    return response;
  }

  /*
  * delete请求
  */
  delete(
    String url, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    late Response response;
    try {
      response = await dio.delete(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      EasyLoading.dismiss();
      if (response.data["errcode"] != 0) {
        EasyLoading.showError(response.data["msg"]);
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print('delete error---------$e');
      }
      formatError(e);
    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    late Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        EasyLoading.showProgress(total.toDouble(), status: '下载中');
        if (kDebugMode) {
          print("$count $total");
        }
      });
      EasyLoading.dismiss();
      if (response.data["errcode"] != 0) {
        EasyLoading.showError(response.data["msg"]);
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print('downloadFile error---------$e');
      }
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (kDebugMode) {
      print("网络请求错误$e");
    }
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      EasyLoading.showError("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      EasyLoading.showError("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      EasyLoading.showError("响应超时");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      EasyLoading.showError("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      if (kDebugMode) {
        print("请求取消");
      }
      EasyLoading.showInfo("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      EasyLoading.showError("未知错误$e",
          duration: const Duration(milliseconds: 10000));
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
