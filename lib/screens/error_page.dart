import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  Exception? error;
  ErrorPage({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: SafeArea(
          child: Center(
        child: Text('No page founded $error'),
      )),
    );
  }
}
