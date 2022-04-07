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
