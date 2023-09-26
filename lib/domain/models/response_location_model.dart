class ResponseLocationModel {
  bool? ok;

  ResponseLocationModel({this.ok});

  ResponseLocationModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    return data;
  }
}
