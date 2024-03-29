
import 'dart:async';

import 'package:gpass/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authControllerProvider = Provider((ref)=>AuthController(authRepository: ref.read(authRepositoryProvider)));


class AuthController{
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository}): _authRepository = authRepository;

  void signUp(BuildContext context,String name,List deviceId,String uid,String deviceDetails, String password,){
    _authRepository.signUpUser(context: context,name: name,deviceId: deviceId,uid:uid,deviceDetails: deviceDetails, password: password, );
  }
  void signIn(BuildContext context,List deviceId, String password,WidgetRef ref){
    _authRepository.signInUser(context: context,deviceId:deviceId,password: password, ref: ref, );
  }
  void addNewDevice(BuildContext context,String deviceId, String newDeviceId,WidgetRef ref){
    _authRepository.addNewDevice(context, deviceId, newDeviceId,ref);
  }
  
  
}