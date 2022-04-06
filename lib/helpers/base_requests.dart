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
import '../services/login_format_validator.dart';

Future<dynamic> onlineLoginAttempt(String userName, String userPassword) async {
  try {
    if (userName.isNotEmpty &&
        userName != "" &&
        userPassword.isNotEmpty &&
        userPassword != "") {
      // check if the user name is of the valid email format
      var format = loginCredentialsValidation(userName, userPassword);

      if (format == "valid") {
        // if user name is email
        // send http request to try to login
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

        if (kDebugMode) {
          log(response.body.toString());
          log(response.statusCode.toString());
        }

        if(response.statusCode==200){
          var respBody = response.body;

          return respBody;

        }else{
          return {};
        }
      } else {
        return {};
      }
    } else {
      return {};
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}
