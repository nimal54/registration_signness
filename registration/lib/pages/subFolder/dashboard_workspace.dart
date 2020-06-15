import 'package:flutter/material.dart';
import 'package:registration/pages/subFolder/BasicInformation.dart';



class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => new _RootPageState();
}
class _RootPageState extends State<RootPage> {
  BasicInformation _basicInformation;

  Widget currentPage;

  @override
  void initState() {
    super.initState();
    _basicInformation = BasicInformation(this.callback);

    currentPage = _basicInformation;
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: currentPage
    );
  }
}


/*
Container(
      child: FlatButton(
      onPressed: () {
        this.widget.callback(new ContactInformation());
      },
      child: new Text('Go to a new page but keep root, just replace this feed part'),
    )
    );
    
    */