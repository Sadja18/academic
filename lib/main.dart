// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './screens/screen_login.dart';
import './screens/screen_dashboard.dart';
import './screens/screen_inspection.dart';
import './screens/screen_teacher_assessment.dart';
import './helpers/base_requests.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget myWidget(BuildContext context) {
    return FutureBuilder(
      future: isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // return const Text('');
        if (snapshot.hasData) {
          if (snapshot.data == 0) {
            return LoginScreen();
          } else if (snapshot.data == 1) {
            return DashboardScreen();
          } else {
            return LoginScreen();
          }
        } else {
          return const Text('');
        }
      },
    );
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
        LoginScreen.routeName: (ctx) => LoginScreen(),
        DashboardScreen.routeName: (ctx) => DashboardScreen(),
        InspectionScreen.routeName: (ctx) => InspectionScreen(),
        TeacherTrainingAssessmentScreen.routeName: (ctx) =>
            TeacherTrainingAssessmentScreen(),
      },
    );
  }
}
