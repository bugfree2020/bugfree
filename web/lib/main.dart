import 'package:app/screen/content_list.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'screen/content_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CI_Bugfree',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: Stack(
            children: [
              BodyContentWidget(sizingInformation: sizingInformation),
            ],
          ),
        );
      },
    );
  }
}
