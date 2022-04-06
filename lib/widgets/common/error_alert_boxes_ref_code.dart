import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String title;
  final String message;
  const ErrorAlert({ Key? key, required this.title, required this.message }) : super(key: key);

  Future<void> _showAlertBox(String title, String message, context) {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title:  Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Re-enter'),
          ),
        ],
      ),
    );
  }
Future<void> _showSuccess(context) {
    const message = "Login success.\nPress okay to go to Dashboard.";
    return showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Successful login'),
        content: const Text(message),
        actions: [
          TextButton(
              onPressed: () {
                // Navigator.of(context).restorablePushNamedAndRemoveUntil(
                //     DashboardScreen.routeName, (route) => false);
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}