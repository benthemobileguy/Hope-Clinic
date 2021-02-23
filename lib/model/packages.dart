class Packages {
  String title;
  String desc;
  List<Plans> plans;

  Packages({this.title, this.desc, this.plans});

  Packages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    if (json['plans'] != null) {
      plans = new List<Plans>();
      json['plans'].forEach((v) {
        plans.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    if (this.plans != null) {
      data['plans'] = this.plans.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String title;
  String price;

  Plans({this.title, this.price});

  Plans.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}