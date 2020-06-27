import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DialogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialogs'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            RaisedButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Success Dialog"),
              onPressed: () =>
                  _customAlertDialog(context, AlertDialogType.SUCCESS),
            ),
            RaisedButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Info Dialog"),
              onPressed: () =>
                  _customAlertDialog(context, AlertDialogType.INFO),
            ),
            RaisedButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Warning Dialog"),
              onPressed: () =>
                  _customAlertDialog(context, AlertDialogType.WARNING),
            ),
            RaisedButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Error Dialog"),
              onPressed: () =>
                  _customAlertDialog(context, AlertDialogType.ERROR),
            ),
          ],
        ),
      ),
    );
  }

  _customAlertDialog(BuildContext context, AlertDialogType type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          type: type,
          title: "Beautiful title",
          content: "Information to your user describing the situation.",
        );
      },
    );
  }
}

enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String content;
  final Widget icon;
  final String buttonLabel;
  final TextStyle titleStyle = TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

  CustomAlertDialog(
      {Key key,
      this.title = "Successful",
      @required this.content,
      this.icon,
      this.type = AlertDialogType.INFO,
      this.buttonLabel = "Ok"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: Container(
            margin: context.isMobile
                ? EdgeInsets.only(left: 30, right: 30)
                : EdgeInsets.only(left: 250, right: 250),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.0),
                icon ??
                    Icon(
                      _getIconForType(type),
                      color: _getColorForType(type),
                      size: 50,
                    ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(
                    content,
                    //textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40.0),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(buttonLabel),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  IconData _getIconForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Icons.warning;
      case AlertDialogType.SUCCESS:
        return Icons.check_circle;
      case AlertDialogType.ERROR:
        return Icons.error;
      case AlertDialogType.INFO:
      default:
        return Icons.info_outline;
    }
  }

  Color _getColorForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Colors.orange;
      case AlertDialogType.SUCCESS:
        return Colors.green;
      case AlertDialogType.ERROR:
        return Colors.red;
      case AlertDialogType.INFO:
      default:
        return Colors.blue;
    }
  }
}
