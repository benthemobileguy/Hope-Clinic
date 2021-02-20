class NextAppointment {
  String y;
  String c;
  String timeLeft;

  NextAppointment({this.y, this.c, this.timeLeft});

  NextAppointment.fromJson(Map<String, dynamic> json) {
    y = json['y'];
    c = json['c'];
    timeLeft = json['timeLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['y'] = this.y;
    data['c'] = this.c;
    data['timeLeft'] = this.timeLeft;
    return data;
  }
}