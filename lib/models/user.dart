// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String name;
  final List deviceId;
  final String uid;
  final String deviceDetails;
  final String token;
  final String password;
  User({
    required this.name,
    required this.deviceId,
    required this.uid,
    required this.deviceDetails,
    required this.password,
    required this.token,
  });

  User copyWith({
    String? name,
    List? deviceId,
    String? uid,
    String? deviceDetails,
    String? password,
    String? token,
  }) {
    return User(
      name: name ?? '',
      
      deviceId: deviceId ?? [],
      uid: uid??'',
      deviceDetails: deviceDetails??'',
      password: password ?? '',
      token: token ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      
      'deviceId': deviceId,
      'uid':uid,
      'deviceDetails': deviceDetails,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      
      deviceId: map['deviceId'] as List,
      uid: map['uid'] as String,
      deviceDetails: map['deviceDetails'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
