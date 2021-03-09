
class Plans {
  bool isTapped = false;
  int id;
  String title;
  String price;
  String accountType;
  String createdAt;
  String updatedAt;

  Plans(
      {this.id,
        this.title,
        this.price,
        this.accountType,
        this.createdAt,
        this.updatedAt});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    accountType = json['account_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['account_type'] = this.accountType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  static List<Plans> fromJsonList(List<dynamic> _list) {
    return _list.map((_plans) => Plans.fromJson(_plans)).toList();
  }
}