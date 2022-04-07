// ignore_for_file: unused_import, unnecessary_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../helpers/base_requests.dart';
import '../helpers/fetch_calls_remote.dart';

import './common/selector_district_dropdown.dart';
import './common/selector_cluster_dropdown.dart';

class AcademicDownloadBase extends StatefulWidget {
  const AcademicDownloadBase({Key? key}) : super(key: key);

  @override
  State<AcademicDownloadBase> createState() => _AcademicDownloadBaseState();
}

class _AcademicDownloadBaseState extends State<AcademicDownloadBase> {
  int initiate = 0;
  var _districtsData = [];

  int hasDistricts = 0;

  Map<String, dynamic> selectedDistrict = {};
  Map<String, dynamic> selectedCluster = {};

  void onInitiated() async {
    var result = await fetchDistrictsFromRemote();

    if (result != null) {
      if (result.isNotEmpty) {
        setState(() {
          initiate = 1;
          hasDistricts = 1;
          _districtsData = result;
        });
      } else {
        hasDistricts = 0;
        _districtsData = [];
      }
    }
  }

  void districtSelector(Map<String, dynamic>? selection) {
    if (kDebugMode) {
      print(selection.toString());
    }
    setState(() {
      selectedDistrict = selection!;
      selectedCluster = {};
    });
  }

  void clusterSelector(Map<String, dynamic>? selection) {
    if (kDebugMode) {
      print(selection.toString());
    }
    setState(() {
      selectedCluster = selection!;
    });
  }

  Future<void> _showAlertBox(String title, String message, context) {
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
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void downloadButtonOnclick() async {
    var res = await getAllSchoolsAndTeachers(
        selectedDistrict['id'], selectedCluster['id']);
    String title = "";
    String message = "";
    if (res == 'ok') {
      title = "Success";
      message = "All records fetched successfully";
    } else {
      title = "Failure";
      message = "All records cannot be fetched successfully";
    }
    _showAlertBox(title, message, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(),
      ),
      child: (initiate == 1)
          ? (hasDistricts == 1)
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white70,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.14,
                        margin: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 6.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(border: Border.all()),
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: const Text(
                                'District',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(border: Border.all()),
                              width: MediaQuery.of(context).size.width * 0.70,
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DistrictDropdownSelector(
                                    districts: _districtsData,
                                    districtSelector: districtSelector,
                                  ),
                                  (selectedDistrict.isNotEmpty)
                                      ? Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),
                                          padding: const EdgeInsets.all(
                                            6.0,
                                          ),
                                          child: Text(
                                            selectedDistrict['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      : const Text(""),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      (selectedDistrict.isNotEmpty)
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white70,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.14,
                              margin: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 6.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    child: const Text(
                                      'Cluster',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    width: MediaQuery.of(context).size.width *
                                        0.70,
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: ClusterDropdown(
                                            districtId: selectedDistrict['id'],
                                            clusterSelector: clusterSelector,
                                            districtName:
                                                selectedDistrict['name'],
                                          ),
                                        ),
                                        (selectedCluster.isNotEmpty)
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                ),
                                                padding: const EdgeInsets.all(
                                                  6.0,
                                                ),
                                                child: Text(
                                                  selectedCluster['name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            : const Text(""),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const Text(""),
                      (selectedCluster.isNotEmpty &&
                              selectedDistrict.isNotEmpty)
                          ? Container(
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
                              height: MediaQuery.of(context).size.height * 0.05,
                              margin: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 6.0,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  downloadButtonOnclick();
                                },
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          : const Text(""),
                    ],
                  ),
                )
              : const Text("No Districts found")
          : Container(
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
              height: MediaQuery.of(context).size.height * 0.05,
              margin: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 6.0,
              ),
              child: TextButton(
                onPressed: () {
                  onInitiated();
                },
                child: const Text(
                  'Initiate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
    );
  }
}
