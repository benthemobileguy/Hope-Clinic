

class Dateslots {
  int id;
  String date;
  int booked;
  String dateTrack;
  List<Timeslots> timeslots;

  Dateslots({this.id, this.date, this.booked, this.dateTrack, this.timeslots});

  Dateslots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    booked = json['booked'];
    dateTrack = json['date_track'];
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
    data['date'] = this.date;
    data['booked'] = this.booked;
    data['date_track'] = this.dateTrack;
    if (this.timeslots != null) {
      data['timeslots'] = this.timeslots.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<Dateslots> fromJsonList(List<dynamic> dates) {
    return dates.map((_dates) => Dateslots.fromJson(_dates)).toList();
  }
}

class Timeslots {
  int id;
  int dateSlotId;
  String startTime;
  String endTime;
  int booked;
  String createdAt;
  String updatedAt;

  Timeslots(
      {this.id,
        this.dateSlotId,
        this.startTime,
        this.endTime,
        this.booked,
        this.createdAt,
        this.updatedAt});

  Timeslots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateSlotId = json['date_slot_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    booked = json['booked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_slot_id'] = this.dateSlotId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['booked'] = this.booked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}