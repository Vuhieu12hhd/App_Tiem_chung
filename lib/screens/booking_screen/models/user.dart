import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int? id;
  String? name;
  String? password;
  String? email;
  String? phoneNumber;
  String? address;
  String? gender;
  String? role;
  bool? active;
  bool? isEmailVerify;
  String? loginMethod;
  int? wrongPasswordCount;
  String? dob;
  User({
    this.id,
    this.name,
    this.password,
    this.email,
    this.phoneNumber,
    this.address,
    this.gender,
    this.role,
    this.active,
    this.isEmailVerify,
    this.loginMethod,
    this.wrongPasswordCount,
    this.dob,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'gender': gender,
      'role': role,
      'active': active,
      'is_email_verified': isEmailVerify,
      'login_method': loginMethod,
      'wrong_password_count': wrongPasswordCount,
      'dob': dob,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      active: map['active'] != null ? map['active'] as bool : null,
      isEmailVerify: map['is_email_verified'] != null
          ? map['is_email_verified'] as bool
          : null,
      loginMethod:
          map['login_method'] != null ? map['login_method'] as String : null,
      wrongPasswordCount: map['wrong_password_count'] != null
          ? map['wrong_password_count'] as int
          : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
