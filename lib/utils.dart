import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    
    SnackBar(
      backgroundColor: const Color.fromARGB(52, 255, 255, 255),
      content: Text(text,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white),),),
  );
}


void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){
  switch (response.statusCode){
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      if(jsonDecode(response.body)['msg'].toString().contains("User already exists!")){
       showSnackBar(context, jsonDecode(response.body)['msg']);
      }
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context,response.body);
  }
}