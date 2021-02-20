
class NextAppointment {
  String timeLeft;

  NextAppointment({this.timeLeft});

  NextAppointment.fromJson(Map<String, dynamic> json) {
    timeLeft = json['timeLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeLeft'] = this.timeLeft;
    return data;
  }
}