import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../helpers/base_requests.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:http/http.dart' as http;

import '../models/uri_paths.dart';
import '../services/login_format_validator.dart';
import './screen_dashboard.dart';
import '../helpers/base_requests.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/screen-login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _userPasswordFocusNode = FocusNode();
  bool _obscurePassword = true;

  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _userPasswordFocus = FocusNode();

  bool _isObscure = true;

  Future<void> _showAlertBox(String title, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Re-enter'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSuccess() {
    const message = "Login success.\nTap okay to go to Dashboard.";
    return showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Successful login'),
        content: const Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .popAndPushNamed(DashboardScreen.routeName);
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }

  void _onLoginSubmit() async {
    var enteredUserName = _usernameController.text;
    var enteredUserPassword = _userPasswordController.text;
    var userName = enteredUserName.trim();
    var userPassword = enteredUserPassword.trim();
    if (kDebugMode) {
      log("Submit clicked");
      log("$userName : $userPassword");
    }

    try {
      var format = loginCredentialsValidation(userName, userPassword);
      log("format $format");

      if (format == "valid") {
        // if user name is email
        // send http request to try to login
        Map<String, String> requestBody = {
          "userName": userName,
          "userPassword": userPassword,
        };
        if (kDebugMode) {
          log("requestBody");
          log(requestBody.toString());
        }

        var response = await http.post(
          Uri.parse('$baseURL$login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestBody),
        );
        if (kDebugMode) {
          log("login status");
          log(response.statusCode.toString());
        }

        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          if (res != null &&
              res.isNotEmpty &&
              res['message'].toString().toLowerCase() == 'success') {
            if (kDebugMode) {
              log('successful online login');
              log(res['data'].toString());
            }

            // save user credentials for offline session
            var academicUserGroup =
                res['data']['academicUserGroup'] == true ? 1 : 0;
            var data = <String, Object>{
              "userName": userName.toString(),
              "userPassword": userPassword.toString(),
              "dbname": res['data']['dbname'],
              "userId": res['data']['userId'],
              "academicUserGroup": academicUserGroup,
              "loginStatus": 1,
              "isOnline": 1
            };
            if (kDebugMode) {
              log(data.toString());
            }
            await insertNewUser(data);

            _showSuccess();
          } else {
            _showAlertBox("Failed Login", "Please check your credentials");
          }
        } else {
          if (kDebugMode) {
            log("response status code not 200");
          }
          switch (response.statusCode) {
            case 404:
              _showAlertBox("Server Error", "Please contact the admin");
              break;
            case 500:
              _showAlertBox("Server Error", "Please try after some time");
              break;
            default:
              _showAlertBox("Failed Login", "Please check your credentials");
              break;
          }
        }
      } else {
        if (kDebugMode) {
          log('offline mode');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log('On click submit error');
        log(e.toString());
      }
      if (e is SocketException) {
        log("write code for offline login attempt");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xfff21bce),
                Color(0xff826cf0),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height,
        // margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/image_back_1.jpeg'),
            scale: 1,
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Table(
                children: [
                  // for username
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "User Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.purpleAccent.shade400,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.purpleAccent.shade100,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  // keyboardAppearance:,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    constraints: BoxConstraints.tightForFinite(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                    ),
                                  ),
                                  controller: _usernameController,
                                  autofocus: false,
                                  focusNode: _userNameFocusNode,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // for user Password
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "User Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.purpleAccent.shade400,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.purpleAccent.shade100,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    constraints: BoxConstraints.tightForFinite(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                    ),
                                    suffixIcon: InkWell(
                                      // color: Colors.white,
                                      onTap: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        alignment: Alignment.centerRight,
                                        child: Icon(_obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                  obscureText: _obscurePassword,
                                  controller: _userPasswordController,
                                  autofocus: false,
                                  focusNode: _userPasswordFocusNode,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  _onLoginSubmit();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xfff21bce),
                        Color(0xff826cf0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                height: MediaQuery.of(context).size.height * 0.20,
                child: Image.asset('assets/icons/icon-144x144.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
