import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio = Dio();
  var subscription;
  DioClient() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("online");
        // reload here
      } else
        print('offlince');
    });
    // _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
    //   requestRetrier: DioConnectivityRequestRetrier(
    //     dio: Dio(),
    //     connectivity: Connectivity(),
    //   ),
    // )); //RetryOnConnectionChangeInterceptor(requestRetrier: )

    // _dio.options.baseUrl = 'https://api.escuelajs.co/api/v1';
    _dio.interceptors.add(DioInterceptor());

    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: print, // specify log function (optional)
        retries: 4, // retry count (optional)
        retryDelays: const [
          // set delays between retries (optional)
          Duration(seconds: 4), // wait 1 sec before the first retry
          // Duration(seconds: 2), // wait 2 sec before the second retry
          // Duration(seconds: 3), // wait 3 sec before the third retry
          // Duration(seconds: 4), // wait 4 sec before the fourth retry
        ],
      ),
    );
  }
  Dio get sendRequest => _dio;

  // }
}

class DioInterceptor extends InterceptorsWrapper {
  //retryRequest()

//  void onError(DioError err, ErrorInterceptorHandler handler) async {
//     // TODO: implement onError
//     super.onError(err, handler);
//     // var threshold = 10
//     // if(thresold<2){
//     var retryRequest = await retryRequest()
//     } handler.reject(error)
//     // else {

//     // }
//   }

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('on Request called');
    options.baseUrl = 'https://api.escuelajs.co/api/v1';
    if (handler.isCompleted) {
      print('on Request completed');
    }
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('on Response called');
    if (handler.isCompleted) {
      print('on Response completed');
      PrettyDioLogger();
    }

    super.onResponse(response, handler);
  }
}
// class DioConnectivityRequestRetrier {
//   final Dio dio;
//   final Connectivity connectivity;

//   DioConnectivityRequestRetrier({
//     required this.dio,
//     required this.connectivity,
//   });

//   Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
//     late StreamSubscription streamSubscription;
//     final responseCompleter = Completer<Response>();

//     streamSubscription = connectivity.onConnectivityChanged.listen(
//       (connectivityResult) {
//         if (connectivityResult != ConnectivityResult.none) {
//           streamSubscription.cancel();
//           responseCompleter.complete(
//             dio.request(
//               requestOptions.path,
//               cancelToken: requestOptions.cancelToken,
//               data: requestOptions.data,
//               onReceiveProgress: requestOptions.onReceiveProgress,
//               onSendProgress: requestOptions.onSendProgress,
//               queryParameters: requestOptions.queryParameters,
//               options: Options(
//                 contentType: requestOptions.contentType,
//                 extra: requestOptions.extra,
//                 followRedirects: requestOptions.followRedirects,
//                 headers: requestOptions.headers,
//                 listFormat: requestOptions.listFormat,
//                 maxRedirects: requestOptions.maxRedirects,
//                 method: requestOptions.method,
//                 receiveTimeout: requestOptions.receiveTimeout,
//                 requestEncoder: requestOptions.requestEncoder,
//                 responseDecoder: requestOptions.responseDecoder,
//                 sendTimeout: requestOptions.sendTimeout,
//                 validateStatus: requestOptions.validateStatus,
//                 receiveDataWhenStatusError:
//                     requestOptions.receiveDataWhenStatusError,
//                 responseType: requestOptions.responseType,
//               ),
//             ),
//           );
//         }
//       },
//     );

//     return responseCompleter.future;
//   }
//}

// class RetryOnConnectionChangeInterceptor extends Interceptor {
//   final DioConnectivityRequestRetrier requestRetrier;

//   RetryOnConnectionChangeInterceptor({
//     required this.requestRetrier,
//   });

//   // RetryOnConnectionChangeInterceptor({
//   //   required this.requestRetrier,
//   // });

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//     if (_shouldRetry(err)) {
//       requestRetrier.scheduleRequestRetry(err.requestOptions);
//     }
//     super.onError(err, handler);
//   }

//   bool _shouldRetry(DioError err) {
//     return err.type == DioErrorType.other &&
//         err.error != null &&
//         err.error is SocketException;
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('on Request called');
//     options.baseUrl = 'https://api.escuelajs.co/api/v1';
//     if (handler.isCompleted) {
//       print('on Request completed');
//     }
//     // TODO: implement onRequest
//     super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print('on Response called');
//     if (handler.isCompleted) {
//       print('on Response completed');
//       PrettyDioLogger();
//     }
//     // void onError(DioError err) {

//     // }
//   }
//}
