import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/screen-login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final userPasswordController = TextEditingController();

  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _userPasswordFocus = FocusNode();

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
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'User Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.purpleAccent.shade400,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purpleAccent.shade100,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          constraints: BoxConstraints.tightForFinite(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.90,
                          ),
                          // hintText: 'User Name',
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                        ),
                        controller: usernameController,
                        autofocus: false,
                        focusNode: _userNameFocus,
                        onEditingComplete: () {
                          _userNameFocus.unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.purpleAccent.shade400,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purpleAccent.shade100,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          constraints: BoxConstraints.tightForFinite(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.90,
                          ),
                          // hintText: 'User Name',
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                        ),
                        controller: userPasswordController,
                        autofocus: false,
                        focusNode: _userPasswordFocus,
                        onEditingComplete: () {
                          _userPasswordFocus.unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [
                      Color(0xfff21bce),
                      Color(0xff826cf0),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.40,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 17,
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