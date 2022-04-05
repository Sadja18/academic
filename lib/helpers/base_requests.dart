// will contain methods for
// online login
// offline login
// upsert user
// logout
// fetch base data: [List of Schools, List of TG Grades, List of Training Names, Remarks]

import 'dart:developer';

import 'package:flutter/foundation.dart';

Future<dynamic> onlineLoginAttempt(String userName, String userPassword)async{
  try {

    if(userName.isNotEmpty && userName != "" && userPassword.isNotEmpty && userPassword != ""){
      return [{
        "message": "success",
        "data": [
          {
            "userName": userName,
            "userPassword": userPassword,
            "dbname": "school"
          }
        ],
      }];
    }
    
  } catch (e) {
    if(kDebugMode){
      log(e.toString());
    }
  }
}