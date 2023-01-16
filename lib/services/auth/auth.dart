


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpass/constants.dart';
import 'package:gpass/models/user.dart';
import 'package:gpass/providers/user_provider.dart';
import 'package:gpass/screens/home_screen.dart';
import 'package:gpass/utils.dart';
import 'package:http/http.dart' as http;

final authRepositoryProvider = Provider((ref)=>AuthRepository());
class AuthRepository {

  void signUpUser({
    required BuildContext context,
    required String name,
    
    required String deviceId,
    required String deviceDetails,
    required String password,
    
    })async{
      try{
        final navigator = Navigator.of(context);
        
        User user = User(
          name: name,
          
          deviceId: deviceId,
          deviceDetails: deviceDetails,
          password: password,
          token: '',
        );
        http.Response res = await http.post(
          Uri.parse('${Constants.uri}/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
        );
        httpErrorHandle(response: res, context: context, onSuccess: (){
          showSnackBar(context, 'Account created successfully! Now login!');
          
        },);
      }catch(e){
        showSnackBar(context, e.toString());
      }

  }
  
  void signInUser({required BuildContext context,required String deviceId,required String password, required WidgetRef ref})async{
    try{
     var userProvider = ref.watch(userRepositoryProvider);
      final navigator = Navigator.of(context);
      
      http.Response res = await  http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        body: jsonEncode({
          'deviceId':deviceId,
       
          'password':password,
         
        }),
        headers: <String , String>{
          'Content-Type':'application/json; charset=UTF-8',
        }
      );
      httpErrorHandle(response: res, context: context, onSuccess: ()async{
        userProvider.setUSer(res.body);
        showSnackBar(context, 'LoggedIn successfully!');
        navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
      
        
      });
    }
    catch(e){
      showSnackBar(context, e.toString());

      
    }

  }
}