class MarketShop {
  int id;
  int userId;
  String title;
  String price;
  int quantity;
  String desc;
  List<String> files;
  String createdAt;

  MarketShop(
      {this.id,
        this.userId,
        this.title,
        this.price,
        this.quantity,
        this.desc,
        this.files,
        this.createdAt});

  MarketShop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    desc = json['desc'];
    files = json['files'].cast<String>();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['desc'] = this.desc;
    data['files'] = this.files;
    data['created_at'] = this.createdAt;
    return data;
  }

  static List<MarketShop> fromJsonList(List<dynamic> _list) {
    return _list.map((_shop) => MarketShop.fromJson(_shop)).toList();
  }
}

class Links {
  String url;
  String label;
  bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}