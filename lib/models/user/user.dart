class UserManual {
  String? username;
  String? email;
  String? password;
  String? first_name;
  String? last_name;
  String? mobile_number;
  String? photo_url;

  UserManual(
      {this.username,
      this.email,
      this.password,
      this.first_name,
      this.last_name,
      this.mobile_number,
      this.photo_url});

  factory UserManual.fromMap(Map<String, dynamic> json) => UserManual(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        mobile_number: json["mobile_number"],
        photo_url: json["photo_url"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "password": password,
        "first_name": first_name,
        "last_name": last_name,
        "mobile_number": mobile_number,
        "photo_url": photo_url,
      };
}

class UserGoogle {
  String? google_uid;
  String? email;
  String? password;
  String? name;
  String? mobile_number;
  String? photo_url;

  UserGoogle(
      {this.google_uid,
      this.email,
      this.password,
      this.name,
      this.mobile_number,
      this.photo_url});

  factory UserGoogle.fromMap(Map<String, dynamic> json) => UserGoogle(
    google_uid: json["google_uid"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    mobile_number: json["mobile_number"],
    photo_url: json["photo_url"],
  );

  Map<String, dynamic> toMap() => {
    "google_uid": google_uid,
    "email": email,
    "password": password,
    "name": name,
    "mobile_number": mobile_number,
    "photo_url": photo_url,
  };
}
