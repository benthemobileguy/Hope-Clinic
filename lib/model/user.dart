
class User {
  int id;
  String firstname;
  String lastname;
  String phoneNumber;
  String email;
  String emailVerifiedAt;
  String dob;
  String profilePhotoUrl;
  String role;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
        this.firstname,
        this.lastname,
        this.phoneNumber,
        this.email,
        this.emailVerifiedAt,
        this.dob,
        this.profilePhotoUrl,
        this.role,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dob = json['dob'];
    profilePhotoUrl = json['profile_photo_url'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['dob'] = this.dob;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}