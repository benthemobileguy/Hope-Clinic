
class Packages {
  int id;
  int userId;
  String title;
  String desc;
  String createdAt;
  String updatedAt;
  List<Plans> plans;
  List<Dateslots> dateslots;

  Packages(
      {this.id,
        this.userId,
        this.title,
        this.desc,
        this.createdAt,
        this.updatedAt,
        this.plans,
        this.dateslots});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['plans'] != null) {
      plans = new List<Plans>();
      json['plans'].forEach((v) {
        plans.add(new Plans.fromJson(v));
      });
    }
    if (json['dateslots'] != null) {
      dateslots = new List<Dateslots>();
      json['dateslots'].forEach((v) {
        dateslots.add(new Dateslots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.plans != null) {
      data['plans'] = this.plans.map((v) => v.toJson()).toList();
    }
    if (this.dateslots != null) {
      data['dateslots'] = this.dateslots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  int id;
  int packageId;
  String title;
  String price;
  String createdAt;
  String updatedAt;

  Plans(
      {this.id,
        this.packageId,
        this.title,
        this.price,
        this.createdAt,
        this.updatedAt});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    title = json['title'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_id'] = this.packageId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Dateslots {
  int id;
  int packageId;
  String date;
  int booked;
  List<Timeslots> timeslots;

  Dateslots({this.id, this.packageId, this.date, this.booked, this.timeslots});

  Dateslots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    date = json['date'];
    booked = json['booked'];
    if (json['timeslots'] != null) {
      timeslots = new List<Timeslots>();
      json['timeslots'].forEach((v) {
        timeslots.add(new Timeslots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_id'] = this.packageId;
    data['date'] = this.date;
    data['booked'] = this.booked;
    if (this.timeslots != null) {
      data['timeslots'] = this.timeslots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeslots {
  int id;
  int packageId;
  int dateSlotId;
  String from;
  String to;
  int booked;
  String createdAt;
  String updatedAt;

  Timeslots(
      {this.id,
        this.packageId,
        this.dateSlotId,
        this.from,
        this.to,
        this.booked,
        this.createdAt,
        this.updatedAt});

  Timeslots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    dateSlotId = json['date_slot_id'];
    from = json['from'];
    to = json['to'];
    booked = json['booked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_id'] = this.packageId;
    data['date_slot_id'] = this.dateSlotId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['booked'] = this.booked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}