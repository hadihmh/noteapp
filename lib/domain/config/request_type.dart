enum HttpRequestType {
  get,
  post,
}

extension StaticHttpRequestType on HttpRequestType {
  static const _type = {
    HttpRequestType.get: "GET",
    HttpRequestType.post: "POST",
  };

  String get type => _type[this] ?? "";
}
