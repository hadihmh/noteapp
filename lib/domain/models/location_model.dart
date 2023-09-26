class LocationModel {
  String? lat;
  String? lang;

  LocationModel({this.lat, this.lang});

  LocationModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    return data;
  }
}
