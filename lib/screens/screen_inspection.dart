import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class InspectionScreen extends StatefulWidget {
  static const routeName = "/screen-inspection";
  const InspectionScreen({Key? key}) : super(key: key);

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inspection'),
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
          actions: [
            IconButton(
              onPressed: () {
                // // print('Home');
                // Navigator.of(context).popAndPushNamed(Dashboard.routeName);
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                // ignore: avoid_print
                // print('logout');
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.create_outlined,
                  semanticLabel: 'Generate Report',
                  size: 40,
                ),
                child: Text(
                  'Mark New',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.8),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.view_list_outlined,
                  semanticLabel: 'View Reports',
                  size: 40,
                ),
                child: Text(
                  'View Marked',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.8),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: const Text('Mark New'),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: const Text('View old'),
            ),
          ],
        ),
      ),
    );
  }
}
