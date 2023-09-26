enum Routes {
  location,
}

extension StaticRoutes on Routes {
  static const _url = {
    Routes.location: "user/location",
  };

  String get url => _url[this] ?? "";
}
