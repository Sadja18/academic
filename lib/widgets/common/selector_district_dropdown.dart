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

class DistrictRadioSelector extends StatefulWidget {
  final List districts;
  final Function(Map<String, dynamic>?) districtSelector;
  const DistrictRadioSelector(
      {Key? key, required this.districts, required this.districtSelector})
      : super(key: key);

  @override
  State<DistrictRadioSelector> createState() => _DistrictRadioSelectorState();
}

class _DistrictRadioSelectorState extends State<DistrictRadioSelector> {
  late Map<String, dynamic> _groupVal;
  @override
  void initState() {
    setState(() {
      _groupVal = {};
    });
    super.initState();
  }

  Widget radioBuild(index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.80,
      child: ListTile(
        // selectedTileColor: Colors.green.shade200,
        // selectedColor: Colors.purple.shade400,
        title: Center(child: Text(widget.districts[index]['name'])),
        leading: Radio<Map<String, dynamic>>(
          value: widget.districts[index],
          groupValue: _groupVal,
          onChanged: (value) {
            if (kDebugMode) {
              print(value.toString());
            }
            setState(() {
              _groupVal = value as Map<String, dynamic>;
            });
            widget.districtSelector(value);
          },
        ),
      ),
    );
  }

  List<Widget> radioButtons() {
    List<Widget> buttonList = [];

    for (var i = 0; i < widget.districts.length; i++) {
      buttonList.add(radioBuild(i));
    }
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.only(
        bottom: 6.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black),
        color: Colors.purple.shade50,
      ),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: radioButtons(),
        ),
      ),
    );
  }
}
