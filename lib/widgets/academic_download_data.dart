// ignore_for_file: unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../helpers/base_requests.dart';
import '../helpers/fetch_calls_remote.dart';

import './common/selector_district_dropdown.dart';

class AcademicDownloadBase extends StatefulWidget {
  const AcademicDownloadBase({Key? key}) : super(key: key);

  @override
  State<AcademicDownloadBase> createState() => _AcademicDownloadBaseState();
}

class _AcademicDownloadBaseState extends State<AcademicDownloadBase> {
  int initiate = 0;
  var _districtsData = [];
  Map<String, dynamic> selectedDistrict = {};

  void onInitiated() async {
    var result = await fetchDistrictsFromRemote();

    setState(() {
      initiate = 1;
      _districtsData = result;
    });
  }

  void districtSelector(Map<String, dynamic>? selection) {
    setState(() {
      selectedDistrict = selection!;
    });
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
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                      ),
                      color: Colors.yellow,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.12,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 6.0,
                    ),
                    padding: const EdgeInsets.only(
                      bottom: 5.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all()),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.12,
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
                          height: MediaQuery.of(context).size.height * 0.12,
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
                                      child: Text(
                                        selectedDistrict['name'],
                                      ),
                                    )
                                  : const Text(""),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                      ),
                      color: Colors.yellow,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
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
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: const Text(
                            'Cluster',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          width: MediaQuery.of(context).size.width * 0.70,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Clusters Dropdown'),
                          ),
                        )
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
                    height: MediaQuery.of(context).size.height * 0.05,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 6.0,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Download',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
