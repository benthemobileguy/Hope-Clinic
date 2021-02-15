class HealthTips {
  int id;
  int userId;
  String segment;
  List<String> files;
  String createdAt;
  String updatedAt;

  HealthTips(
      {this.id,
        this.userId,
        this.segment,
        this.files,
        this.createdAt,
        this.updatedAt});

  HealthTips.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    segment = json['segment'];
    files = json['files'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['segment'] = this.segment;
    data['files'] = this.files;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  static List<HealthTips> fromJsonList(List<dynamic> _list) {
    return _list.map((_tips) => HealthTips.fromJson(_tips)).toList();
  }
}