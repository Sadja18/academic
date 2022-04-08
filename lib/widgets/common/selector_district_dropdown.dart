import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DistrictDropdownSelector extends StatefulWidget {
  final List districts;
  final Function(Map<String, dynamic>?) districtSelector;
  const DistrictDropdownSelector(
      {Key? key, required this.districts, required this.districtSelector})
      : super(key: key);

  @override
  State<DistrictDropdownSelector> createState() =>
      _DistrictDropdownSelectorState();
}

class _DistrictDropdownSelectorState extends State<DistrictDropdownSelector> {
  List<dynamic> _districts = [];
  Map<String, dynamic> selectedDistrict = {};
  String value = "{}";
  @override
  void initState() {
    setState(() {
      _districts = widget.districts;
      selectedDistrict = widget.districts[0];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: DropdownButton(
        hint: const Text('Select District'),
        items: _districts.map<DropdownMenuItem<String>>((e) {
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
        onChanged: (selectedItem) {
         
          setState(() {
            selectedDistrict = jsonDecode(selectedItem.toString());
          });
          widget.districtSelector(selectedDistrict);
        },
      ),
    );
  }
}
