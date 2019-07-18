import 'package:flutter/material.dart';

import 'shared_widgets.dart';

// should be exposed to other classes for notification triggering
final notificationBarKey = GlobalKey<NotificationBarState>();

class DemoWithGlobalKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trigger animation using GlobalKey"),
      ),
      body: Stack(
        children: <Widget>[
          NotificationBar(
            key: notificationBarKey,
            contentWidget: TriggerNotificationWidget(onPressed: () {
              final notificationBarState = notificationBarKey.currentState;
              if (notificationBarState != null &&
                  notificationBarState.mounted) {
                notificationBarState.showNotification();
              }
            }),
            barWidget: NewNotificationWidget(),
          ),
        ],
      ),
    );
  }
}

class NotificationBar extends StatefulWidget {
  final Widget contentWidget;
  final Widget barWidget;

  NotificationBar(
      {Key key, @required this.contentWidget, @required this.barWidget})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NotificationBarState();
}

class NotificationBarState extends State<NotificationBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _offset = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void showNotification() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.contentWidget,
        SlideTransition(
          position: _offset,
          child: widget.barWidget,
        ),
      ],
    );
  }
}
