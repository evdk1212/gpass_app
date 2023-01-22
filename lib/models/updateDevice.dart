// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateModel {
  
  
  final String deviceId;
  final String newDeviceId;
  
  UpdateModel({
   
    required this.deviceId,
    required this.newDeviceId,
    
  });

  UpdateModel copyWith({
    
    
    String? deviceId,
    String? newDeviceId,
   
  }) {
    return UpdateModel(
      
      
      deviceId: deviceId ?? '',
      newDeviceId: newDeviceId??'',
      
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      
      
      'deviceId': deviceId,
      'newDeviceId': newDeviceId,
      
    };
  }

  factory UpdateModel.fromMap(Map<String, dynamic> map) {
    return UpdateModel(
      
      deviceId: map['deviceId'] as String,
      newDeviceId: map['newDeviceId'] as String,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateModel.fromJson(String source) =>
      UpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
