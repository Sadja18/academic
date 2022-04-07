// for fetch calls of
// base data download,
// district data download,
// cluster data download,
// school data download
// teacher data download
// from remote server

import 'dart:convert';
import 'dart:developer';

import 'package:academic/services/database.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/uri_paths.dart';

Future<dynamic> fetchDistrictsFromRemote() async {
  try {
    var customQueryCredential =
        "SELECT userName, userPassword FROM user WHERE loginStatus = 1;";
    var params = [];

    var credentials =
        await DBProvider.db.dynamicRead(customQueryCredential, params);

    if (credentials.isNotEmpty) {
      var credential = credentials[0];

      var userName = credential['userName'];
      var userPassword = credential['userPassword'];

      Map<String, dynamic> requestBody = {
        "userName": userName,
        "userPassword": userPassword,
      };
      var response = await http.post(
        Uri.parse('$baseURL$fetchdistricts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body != "") {
          var resp = jsonDecode(response.body);

          if (resp['message'] != null && resp['message'] == 'success') {
            if (resp['data'] != null && resp['data'].isNotEmpty) {
              var academicYearData = resp['data']['academicYear'];

              if (academicYearData != null) {
                // save to db

                Map<String, Object> data = {
                  "sessionId": academicYearData['id'],
                  "sessionName": academicYearData['name'],
                  "sessionStartDate": academicYearData['date_start'],
                  "sessionEndDate": academicYearData['date_stop'],
                };

                await DBProvider.db.dynamicInsert('AcademicSession', data);
              }

              var districtData = resp['data']['districts'];

              if (districtData != null && districtData.length > 0) {
                // return to academic_download_data.dart

                return districtData;
              }
            }
          }
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}

Future<dynamic> fetchClustersInDistrict(districtId) async {
  try {
    var customQueryCredential =
        "SELECT userName, userPassword FROM user WHERE loginStatus = 1;";
    var params = [];

    var credentials =
        await DBProvider.db.dynamicRead(customQueryCredential, params);

    if (credentials.isNotEmpty) {
      var credential = credentials[0];

      var userName = credential['userName'];
      var userPassword = credential['userPassword'];

      Map<String, dynamic> requestBody = {
        "userName": userName,
        "userPassword": userPassword,
        "districtId": districtId,
      };
      var response = await http.post(
        Uri.parse('$baseURL$fetchclustersindistrict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body != "") {
          var resp = jsonDecode(response.body);

          if (resp['message'] != null && resp['message'] == 'success') {
            if (resp['data'] != null && resp['data'].isNotEmpty) {
              var clusterData = resp['data'];

              if (clusterData != null && clusterData.length > 0) {
                // return to academic_download_data.dart
                return clusterData;
              }
            }
          }
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}

Future<dynamic> getAllSchoolsAndTeachers(districtId, clusterId) async {
  try {
    if (kDebugMode) {
      print("sending request to download stuff");
    }
    var customQueryCredential =
        "SELECT userName, userPassword FROM user WHERE loginStatus = 1;";
    var params = [];

    var credentials =
        await DBProvider.db.dynamicRead(customQueryCredential, params);
    int flag = 0;

    if (credentials.isNotEmpty) {
      var credential = credentials[0];

      var userName = credential['userName'];
      var userPassword = credential['userPassword'];

      Map<String, dynamic> requestBody = {
        "userName": userName,
        "userPassword": userPassword,
        "districtId": districtId,
        'clusterId': clusterId
      };
      var response = await http.post(
        Uri.parse('$baseURL$fetchAllSchoolsAndTeachers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body != "") {
          var resp = jsonDecode(response.body);

          if (resp['message'] != null && resp['message'] == 'success') {
            if (resp['data'] != null && resp['data'].isNotEmpty) {
              if (resp['data'] is Map &&
                  resp['data']['schools'] != null &&
                  resp['data']['teachers'] != null) {
                if (resp['data']['schools'] is List &&
                    resp['data']['schools'].length > 0) {
                  var schools = resp['data']['schools'];

                  for (var i = 0; i < schools.length; i++) {
                    var school = schools[i];
                    if (kDebugMode) {
                      print(school.toString());
                    }
                    Map<String, Object> entry = {
                      "schoolId": school['id'],
                      "schoolName": school['com_name'].toString(),
                      'schoolCode': school['code'],
                      'schoolClusterId': school['cluster'][0],
                      'schoolClusterName': school['cluster'][1].toString(),
                      'schoolBlockId': school['block'][0],
                      'schoolBlockName': school['block'][1].toString(),
                    };

                    await DBProvider.db.dynamicInsert('School', entry);
                  }
                } else {
                  flag = 1;
                }
                if (resp['data']['teachers'] is List &&
                    resp['data']['teachers'].length > 0) {
                } else {
                  flag = 1;
                }
              }
            }
          }
        }
      }
    } else {
      flag = 1;
    }
    if (flag == 0) {
      return 'ok';
    } else {
      return 'not ok';
    }
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
  }
}
