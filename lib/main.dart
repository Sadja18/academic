// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './screens/screen_login.dart';
import './screens/screen_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget myWidget(BuildContext context) {
    // return FutureBuilder(
    //   future: loginOrDashboard(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     // return const Text('');
    //     if (snapshot.hasData) {
    //       if (snapshot.data == 'login') {
    //         return LoginScreen();
    //       } else {
    //         return DashboardScreen();
    //       }
    //     } else {
    //       return const Text('');
    //     }
    //   },
    // );
    // return LoginScreen();
    return DashboardScreen();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        fontFamily: 'Merriweather',
        backgroundColor: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.3,
              fontSizeDelta: 0.5,
              fontFamily: 'Merriweather',
            ),
      ),
      initialRoute: '/',
      routes: {
        "/": (ctx) => myWidget(ctx),
        DashboardScreen.routeName: (ctx)=> DashboardScreen(),
      },
    );
  }
}
