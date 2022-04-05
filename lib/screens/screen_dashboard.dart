import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './screen_inspection.dart';
import './screen_teacher_assessment.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/screen-dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
                  child: const ListTile(
                    title: Text('User Name'),
                    tileColor: Colors.transparent,
                  ),
                ),
                ListTile(
                  title: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // wrapper();
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
                      },
                      child: const Text('Sync Data'),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // _onLogout();
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
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: const Text('Download'),
            ),
            Container(
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
                              height: MediaQuery.of(context).size.height * 0.20,
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
                              height: MediaQuery.of(context).size.height * 0.20,
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
            ),
          ],
        ),
      ),
    );
  }
}
