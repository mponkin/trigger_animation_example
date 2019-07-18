import 'package:flutter/material.dart';

class TriggerNotificationWidget extends StatelessWidget {
  final Function onPressed;

  TriggerNotificationWidget({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Trigger notification"),
        onPressed: onPressed,
      ),
    );
  }
}

class NewNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("New notification!"),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.lightGreen, shape: BoxShape.circle),
            )
          ],
        ),
      ),
    );
  }
}
