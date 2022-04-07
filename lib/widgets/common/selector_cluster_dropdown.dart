import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../helpers/fetch_calls_remote.dart';

class ClusterDropdown extends StatefulWidget {
  final List clusters;
  final Function(Map<String, dynamic>?) clusterSelector;
  const ClusterDropdown(
      {Key? key, required this.clusters, required this.clusterSelector})
      : super(key: key);

  @override
  State<ClusterDropdown> createState() => _ClusterDropdownState();
}

class _ClusterDropdownState extends State<ClusterDropdown> {
  // int _cl = -1;
  List _clusters = [];

  @override
  void initState() {
    _clusters = widget.clusters;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
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
      ),
    );
  }
}
