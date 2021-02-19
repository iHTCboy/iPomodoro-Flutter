import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        brightness: Brightness.dark,
      ),
      body: Center(
          child: Text('text')
      ),
    );
  }
}
