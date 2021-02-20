
class ReservedItem {
  int id;
  int userId;
  int storeId;
  int quantity;
  String createdAt;
  Store store;

  ReservedItem(
      {this.id,
        this.userId,
        this.storeId,
        this.quantity,
        this.createdAt,
        this.store});

  ReservedItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    return data;
  }

  static List<ReservedItem> fromJsonList(List<dynamic> _list) {
    return _list.map((_item) => ReservedItem.fromJson(_item)).toList();
  }
}

class Store {
  int id;
  int userId;
  String title;
  String price;
  int quantity;
  String desc;
  List<String> files;
  String createdAt;

  Store(
      {this.id,
        this.userId,
        this.title,
        this.price,
        this.quantity,
        this.desc,
        this.files,
        this.createdAt});

  Store.fromJson(Map<String, dynamic> json) {
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