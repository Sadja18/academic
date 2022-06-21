// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../helpers/fetch_calls_remote.dart';

class ClusterDropdown extends StatefulWidget {
  final int districtId;
  final String districtName;
  final Function(Map<String, dynamic>?) clusterSelector;
  const ClusterDropdown(
      {Key? key,
      required this.districtId,
      required this.clusterSelector,
      required this.districtName})
      : super(key: key);

  @override
  State<ClusterDropdown> createState() => _ClusterDropdownState();
}

class _ClusterDropdownState extends State<ClusterDropdown> {
  Widget dropdownWidget(_clusters) {
    return DropdownButton(
      hint: const Text("Select Cluster"),
      items: _clusters.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(e['name']),
          ),
          value: jsonEncode(e),
        );
      }).toList(),
      onChanged: (selection) {
        widget.clusterSelector(jsonDecode(selection.toString()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: fetchClustersInDistrict(widget.districtId),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("Internal Server Error");
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var _clusters = snapshot.data;
              return dropdownWidget(_clusters);
            } else {
              String returnVal =
                  'No clusters found for\nDistrict' + widget.districtName;
              return Text(
                returnVal,
                maxLines: 2,
              );
            }
          } else {
            String returnVal =
                'No clusters found for\nDistrict: ' + widget.districtName;
            return Text(
              returnVal,
              maxLines: 2,
            );
          }
        },
      ),
    );
  }
}

class RadioMenuBuilder extends StatefulWidget {
  final Function(Map<String, dynamic>?) clusterSelector;
  final List clusters;
  const RadioMenuBuilder(
      {Key? key, required this.clusterSelector, required this.clusters})
      : super(key: key);

  @override
  State<RadioMenuBuilder> createState() => _RadioMenuBuilderState();
}

class _RadioMenuBuilderState extends State<RadioMenuBuilder> {
  late Map<String, dynamic> _groupVal;
  @override
  void initState() {
    setState(() {
      _groupVal = {};
    });
    super.initState();
  }

  Widget radioBuild(cluster) {
    return ListTile(
      title: Center(
        child: Text(
          cluster['name'],
        ),
      ),
      leading: Radio<Map<String, dynamic>>(
        groupValue: _groupVal,
        value: cluster,
        onChanged: (value) {
          setState(() {
            _groupVal = value as Map<String, dynamic>;
          });
          widget.clusterSelector(value);
        },
      ),
    );
  }

  Widget radioWidget(clusters) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(clusters.length, (index) {
            return radioBuild(clusters[index]);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.purple),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
      child: radioWidget(widget.clusters),
    );
  }
}

class ClusterRadioSelector extends StatefulWidget {
  final int districtId;
  final String districtName;
  final Function(Map<String, dynamic>?) clusterSelector;
  const ClusterRadioSelector(
      {Key? key,
      required this.districtId,
      required this.districtName,
      required this.clusterSelector})
      : super(key: key);

  @override
  State<ClusterRadioSelector> createState() => _ClusterRadioSelectorState();
}

class _ClusterRadioSelectorState extends State<ClusterRadioSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.20,
      child: FutureBuilder(
        future: fetchClustersInDistrict(widget.districtId),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("Internal Server Error");
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var _clusters = snapshot.data;
              return RadioMenuBuilder(
                  clusterSelector: widget.clusterSelector, clusters: _clusters);
            } else {
              String returnVal =
                  'No clusters found for\nDistrict' + widget.districtName;
              return Text(
                returnVal,
                maxLines: 2,
              );
            }
          } else {
            String returnVal =
                'No clusters found for\nDistrict: ' + widget.districtName;
            return Text(
              returnVal,
              maxLines: 2,
            );
          }
        },
      ),
    );
  }
}
