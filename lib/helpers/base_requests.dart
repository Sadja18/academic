// will contain methods for
// online login
// offline login
// upsert user
// logout
// fetch base data: [List of Schools, List of TG Grades, List of Training Names, Remarks]

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/uri_paths.dart';

Future<dynamic> onlineLoginAttempt(String userName, String userPassword) async {
  try {
    if (userName.isNotEmpty &&
        userName != "" &&
        userPassword.isNotEmpty &&
        userPassword != "") {
      Map<String, String> requestBody = {
        "userName": userName,
        "userPassword": userPassword,
      };

      var response = await http.post(
        Uri.parse('$baseURL$login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if(kDebugMode){
        log(response.toString());
      }
      return response;
    } else {
      return {};
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}
