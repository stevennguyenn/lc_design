enum DioHttpMethod { get, post, put, delete, patch }

extension ValueHttpMethod on DioHttpMethod {
  String get value {
    switch (index) {
      case 0:
        return "GET";
      case 1:
        return "POST";
      case 2:
        return "PUT";
      case 3:
        return "DELETE";
      case 4:
        return "PATCH";
    }
    return "";
  }
}
