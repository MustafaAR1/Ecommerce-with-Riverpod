import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio = Dio();
  DioClient() {
    _dio.interceptors.add(DioInterceptor());
    _dio.interceptors.add(PrettyDioLogger());
    // _dio.options.baseUrl = 'https://api.escuelajs.co/api/v1';
    // _dio.interceptors.add(
    //     //PrettyDioLogger()
    //     InterceptorsWrapper(
    //   onRequest: (e, handler) {
    //     //  e.baseUrl = 'https://api.escuelajs.co/api/v1';
    //     // PrettyDioLogger();
    //   },
    //   onResponse: (e, handler) => PrettyDioLogger(),
    // )
    //     //
    //     );
  }
  Dio get sendRequest => _dio;

  // }
}

class DioInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = 'https://api.escuelajs.co/api/v1';
    if (handler.isCompleted) {}
    // TODO: implement onRequest
    // PrettyDioLogger();
    super.onRequest(options, handler);
  }

}
