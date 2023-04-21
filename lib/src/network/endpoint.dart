import 'package:dio/dio.dart';
import 'package:lc_design/src/network/request_methods.dart';

class EndpointType {
  EndpointType({
    this.path,
    this.httpMethod,
    this.parameters,
    this.header = const {},
    this.responseType,
  });

  final String? path;
  final DioHttpMethod? httpMethod;
  final Map<String, dynamic>? parameters;
  final Map<String, String> header;
  final ResponseType? responseType;
}

class DefaultHeader {
  DefaultHeader._();

  static final DefaultHeader instance = DefaultHeader._();

  Map<String, String> get defaultHeader {
    Map<String, String> header = <String, String>{};
    header["Content-Type"] = "application/json";
    return header;
  }

  Map<String, String> get emptyHeader {
    Map<String, String> header = <String, String>{};
    return header;
  }
}
