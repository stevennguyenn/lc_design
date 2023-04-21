import 'dart:typed_data';

class BaseResponse {
  final String? message;
  final int? code;
  final dynamic data;
  final String? token;

  const BaseResponse({
    this.message,
    this.code,
    this.data,
    this.token,
  });

  bool get status {
    return code == 0 || code == null;
  }

  factory BaseResponse.fromSuccessJson(
    Map<String, dynamic> json,
    String? token,
    String? jsonString,
  ) {
    return BaseResponse(
      code: json["errorCode"],
      data: json["data"],
      token: token,
    );
  }

  factory BaseResponse.fromSuccessBytes(
    Map<String, dynamic> json,
    String? token,
    Uint8List? bytes,
  ) {
    return BaseResponse(
      code: json["errorCode"],
      data: json["data"],
      token: token,
    );
  }

  factory BaseResponse.fromErrorJson(Map<String, dynamic> json) {
    return BaseResponse(
      code: json["errorCode"],
      message: json["description"],
    );
  }
}
