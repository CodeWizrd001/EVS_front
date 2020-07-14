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
                height: 30,
              ),
              Text("RadCounter App       ", style: aboutStyle),
              SizedBox(height: 5),
              Text("Version : PreRelease ", style: aboutStyle),
              SizedBox(height: 50),
              Container(
                height: 200,
                child: ListView(
                  children: <Widget>[
                    Text("     Authors :                     ",
                        style: aboutStyle),
                    SizedBox(
                      height: 10,
                    ),
                    Text("             Arjun Syam  -  B180031CS",
                        style: aboutStyle),
                    Text("             Arjun B J   -  B180287CS",
                        style: aboutStyle),
                    Text("             Suraj Patil -  B180282CS",
                        style: aboutStyle),
                    Text("             Praveen E   -  B180692CS",
                        style: aboutStyle),
                    Text("             Ajay P S    -  B180341CS",
                        style: aboutStyle),
                  ],
                ),
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
