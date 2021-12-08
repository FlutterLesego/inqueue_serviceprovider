class UserModel {
  String? uid;
  String? email;
  String? phone;
  String? name;
  String? location;
  String? password;

  UserModel({this.uid, this.email,this.phone, this.name, this.location, this.password});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      name: map['name'],
      location: map['location'],
      password: map['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'name': name,
      'location': location,
      'password': password,
    };
  }
}
