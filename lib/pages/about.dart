import 'package:flutter/material.dart';

TextStyle aboutStyle = TextStyle(
  fontSize: 20,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "RadCounter App",
                style: aboutStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Version : Alpha",
                style: aboutStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Author : Wizard",
                style: aboutStyle,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
