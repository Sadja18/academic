// will contain methods for
// online login
// offline login
// upsert user
// logout
// fetch base data: [List of Schools, List of TG Grades, List of Training Names, Remarks]

import 'dart:convert';
import 'dart:developer';

import 'package:academic/services/database.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/uri_paths.dart';
import '../services/login_format_validator.dart';

// Future<dynamic> onlineLoginAttempt(String userName, String userPassword) async {
//   try {
//     if (userName.isNotEmpty &&
//         userName != "" &&
//         userPassword.isNotEmpty &&
//         userPassword != "") {
//       // check if the user name is of the valid email format

//         if (kDebugMode) {
//           print(response.body.toString());
//           print(response.statusCode.toString());
//         }

//         if (response.statusCode == 200) {
//           var respBody = jsonDecode(response.body);

//           return respBody;
//         } else {
//           return {};
//         }
//       } else {
//         return {};
//       }
//     } else {
//       return {};
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       log(e.toString());
//     }
//     // return {};
//   }
// }

Future<void> insertNewUser(Map<String, dynamic> data) async {
  try {
    await DBProvider.db.dynamicInsert('user', data);
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}

Future<dynamic> isLoggedIn() async {
  try {
    String customQuery = "SELECT * FROM user WHERE loginStatus = 1;";
    var params = [];
    var result = await DBProvider.db.dynamicRead(customQuery, params);

    if (result.length == 1) {
      var res = result[0];

      if (res['loginStatus'] == 1) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}

Future<void> logUserOut() async {
  try {
    await DBProvider.db.makeuserLoggedOut();
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}

Future<dynamic> getUserName() async {
  try {
    String customQuery = "SELECT * FROM user WHERE loginStatus = 1;";
    var params = [];
    var result = await DBProvider.db.dynamicRead(customQuery, params);

    if (result.length == 1) {
      var res = result[0];
      if (res['userName'] != null) {
        return res['userName'].toString();
      } else {
        return "";
      }
    } else {
      return "";
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}

Future<dynamic> userType() async {
  try {
    var customQuery = 'SELECT academicUserGroup FROM user WHERE loginStatus=1;';
    var params = [];

    var results = await DBProvider.db.dynamicRead(customQuery, params);
    if (results.length == 1) {
      var result = results[0];

      return result['academicUserGroup'];
    } else {
      return -1;
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}
