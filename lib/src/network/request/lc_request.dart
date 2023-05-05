import 'package:dio/dio.dart';
import '../base_response.dart';
import '../endpoint.dart';
import '../network_config.dart';
import '../request_methods.dart';

abstract class LCRequestProtocol {
  Future<BaseResponse> requestData(EndpointType endpointType);
}

class LCRequest extends LCRequestProtocol {
  LCRequest._();

  static final LCRequest instance = LCRequest._();

  Dio? dio;

  Dio init() {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = NetworkConfig.baseUrl;
      dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          //final token = LiveData.token;

          // if (token.isNotEmpty) {
          //   options.headers['Authorization'] = token;
          // }

          return handler.next(options);
        },
        onResponse: (e, handler) {
          final statusCode = e.statusCode;

          if (statusCode == 401) {
            return handler.reject(
              DioError(
                requestOptions: e.requestOptions,
                type: DioErrorType.cancel,
              ),
            );
          }
          return handler.resolve(e);
        },
        onError: (ex, handler) async {
          return handler.reject(ex);
        },
      ));
    }

    return dio!;
  }

  @override
  Future<BaseResponse> requestData(EndpointType endpointType) async {
    Dio dio = init();
    final header = endpointType.header;
    Response response;

    try {
      if (endpointType.httpMethod == DioHttpMethod.get) {
        response = await dio.request(
          endpointType.path!,
          queryParameters: endpointType.parameters,
          options: Options(
            headers: header,
            method: endpointType.httpMethod!.value,
            responseType: endpointType.responseType,
            validateStatus: (status) {
              if (status == null) {
                return false;
              }
              return status <= 500;
            },
          ),
        );
      } else {
        response = await dio.request(
          endpointType.path!,
          data: endpointType.parameters,
          options: Options(
            headers: header,
            method: endpointType.httpMethod!.value,
            responseType: endpointType.responseType,
            validateStatus: (status) {
              if (status == null) {
                return false;
              }
              return status <= 500;
            },
          ),
        );
      }

      final json = response.data;
      int statusCode = response.statusCode!;

      if (json != null) {
        if (statusCode >= 200 && statusCode < 300) {
        } else {
          return BaseResponse.fromErrorJson(json);
        }
      }
    } catch (e) {
      return BaseResponse(
        code: 1,
        message: "$e",
      );
    }

    return const BaseResponse();
  }
}
