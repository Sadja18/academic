// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './screen_login.dart';
import './screen_inspection.dart';
import './screen_teacher_assessment.dart';
import '../widgets/academic_download_data.dart';
import '../helpers/base_requests.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/screen-dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget widgetUserName() {
    return FutureBuilder(
      future: getUserName(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("");
        }
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            var userName = snapshot.data;
            return Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          }
        }
        return const Text("");
      },
    );
  }

  void logOutButtonOnClick() async {
    await logUserOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }

  Widget downloadTabWidget() {
    return FutureBuilder(
      future: userType(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Internal Server Error');
        }
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            if (snapshot.data == 1) {
              return AcademicDownloadBase();
            } else if (snapshot.data == 0) {
              return const Text('Download for DIET');
            } else {
              return const Text('');
            }
          }
        }
        return const Text("");
      },
    );
  }

  Widget activityTabWidget() {
    return FutureBuilder(
      future: userType(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Internal Server Error');
        }
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            if (snapshot.data == 1) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(InspectionScreen.routeName);
                        },
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Image.asset(
                                    'assets/dashboardIcons/assessment.png'),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.50,
                                // height: MediaQuery.of(context).size.height * 0.20,
                                child: const Text('Inspection'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              TeacherTrainingAssessmentScreen.routeName);
                        },
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Image.asset(
                                    'assets/dashboardIcons/leave.png'),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.50,
                                // height: MediaQuery.of(context).size.height * 0.20,
                                child: const Text('Assessment'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.data == 0) {
              return Container(
                decoration: BoxDecoration(border: Border.all()),
                child: const Text('DIET Activity'),
              );
            } else {
              return const Text('');
            }
          }
        }
        return const Text('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = kToolbarHeight;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
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
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.download_for_offline_outlined,
                  semanticLabel: 'Fetch Data',
                  size: 40,
                ),
                child: Text(
                  'Download',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.8),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.view_list_outlined,
                  semanticLabel: 'Processes',
                  size: 40,
                ),
                child: Text(
                  'Activity',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.8),
                ),
              ),
            ],
          ),
        ),
        endDrawer: Container(
          padding: EdgeInsets.only(top: statusBarHeight + appBarHeight + 1),
          child: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.shade100,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    title: Center(child: widgetUserName()),
                    tileColor: Colors.transparent,
                  ),
                ),
                ListTile(
                  title: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // wrapper();
                        if (kDebugMode) {
                          log("Fetch data");
                        }
                      },
                      child: const Text('Fetch Data'),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // wrapper();
                        if (kDebugMode) {
                          log("Upload data");
                        }
                      },
                      child: const Text('Sync Data'),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        logOutButtonOnClick();
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: downloadTabWidget(),
            ),
            activityTabWidget(),
          ],
        ),
      ),
    );
  }
}
