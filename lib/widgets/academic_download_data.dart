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
  Map<String, dynamic> prevDistrict = {};

  Map<String, dynamic> selectedCluster = {};

  int selectDistrict = 0;
  int selectCluster = 0;

  void showDistrictSelector() {
    setState(() {
      selectDistrict = (selectDistrict == 1) ? 0 : 1;
      // selectedDistrict = (selectDistrict==0) {};
    });
  }

  void showClusterSelector() {
    setState(() {
      selectCluster = selectCluster == 1 ? 0 : 1;
    });
  }

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
      print("Selection ov er");
      print(selection.toString());
    }
    setState(() {
      prevDistrict = selectedDistrict;
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
    // String title = "";
    // String message = "";
    // if (res == 'ok') {
    //   title = "Success";
    //   message = "All records fetched successfully";
    // } else {
    //   title = "Failure";
    //   message = "All records cannot be fetched successfully";
    // }
    // _showAlertBox(title, message, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // padding: const EdgeInsets.symmetric(
      //   vertical: 6.0,
      // ),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        // border: Border.all(),
      ),
      child: (initiate == 0)
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
            )
          : (hasDistricts == 0)
              ? const Text("No Districts found")
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          // color: Colors.red,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.75,
                        margin: const EdgeInsets.symmetric(
                          vertical: 3.0,
                          horizontal: 6.0,
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment(-0.95, 0.0),
                                  end: Alignment(1.0, 0.0),
                                  colors: [
                                    Color.fromARGB(255, 245, 142, 228),
                                    Color.fromARGB(255, 157, 141, 236),
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                top: 6.0,
                                bottom: 3.0,
                              ),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.center,
                                  primary: Colors.transparent,
                                ),
                                onPressed: () {
                                  showDistrictSelector();
                                },
                                child: Text(
                                  (selectDistrict == 0)
                                      ? "Show District Selector"
                                      : "Close District Selector",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            (selectDistrict == 0)
                                ? const Text("")
                                : DistrictRadioSelector(
                                    districts: _districtsData,
                                    districtSelector: districtSelector),
                            (selectDistrict == 0 && selectedDistrict.isNotEmpty)
                                ? Container(
                                    alignment: Alignment.topCenter,
                                    margin: const EdgeInsets.only(
                                      bottom: 3.0,
                                    ),
                                    decoration: const BoxDecoration(
                                        // border: Border.all(
                                        // color: Colors.green,
                                        // ),
                                        // color: Colors.white,
                                        ),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.30,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                child: const Text(
                                                  "Selected District",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.60,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                child: Text(
                                                    selectedDistrict['name']),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // widget for cluster radio
                                        (selectedDistrict.isEmpty)
                                            ? const Text(
                                                'No clusters in this district')
                                            : Container(
                                                margin: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8.0,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8.0,
                                                        ),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin: Alignment(
                                                              -0.95, 0.0),
                                                          end: Alignment(
                                                              1.0, 0.0),
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                245, 142, 228),
                                                            Color.fromARGB(255,
                                                                157, 141, 236),
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        ),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                        bottom: 8.0,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          showClusterSelector();
                                                        },
                                                        child: Text(
                                                          (selectCluster == 1)
                                                              ? "Close Cluster Selector"
                                                              : "Show Cluster Selector",
                                                          style:
                                                              const TextStyle(
                                                            // fontWeight:
                                                            // FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    (selectCluster == 1)
                                                        ? Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: Colors
                                                                        .blue),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.30,
                                                            child:
                                                                ClusterRadioSelector(
                                                              districtId:
                                                                  selectedDistrict[
                                                                      'id'],
                                                              districtName:
                                                                  selectedDistrict[
                                                                      'name'],
                                                              clusterSelector:
                                                                  clusterSelector,
                                                            ),
                                                          )
                                                        : const Text(""),
                                                    (selectCluster == 0 &&
                                                            selectedCluster
                                                                .isNotEmpty)
                                                        ? Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: Colors
                                                                        .white),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border
                                                                        .all(),
                                                                  ),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.30,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.08,
                                                                  child:
                                                                      const Text(
                                                                    "Selected Cluster",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border
                                                                        .all(),
                                                                  ),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.60,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.08,
                                                                  child: Text(
                                                                      selectedCluster[
                                                                          'name']),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const Text(""),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  )
                                : const Text(''),
                            (selectedCluster.isEmpty ||
                                    selectedDistrict.isEmpty)
                                ? const Text("")
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
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Download",
                                        style: TextStyle(
                                          color: Colors.white,
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
