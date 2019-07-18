import 'dart:async';

import 'package:flutter/material.dart';

import 'shared_widgets.dart';

// instantiating StreamController here for simplicity.
// Actually stream should come from BLoC or StreamProvider which is connected to your model
final notificationStreamController = StreamController();

class DemoWithStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trigger animation using Stream"),
        ),
        body: NotificationBar(
          notificationStream: notificationStreamController.stream,
          contentWidget: TriggerNotificationWidget(onPressed: () {
            notificationStreamController.add(null);
          }),
          barWidget: NewNotificationWidget(),
        ));
  }
}

class NotificationBar extends StatefulWidget {
  final Widget contentWidget;
  final Widget barWidget;
  final Stream<void> notificationStream;

  NotificationBar(
      {@required this.contentWidget,
      @required this.barWidget,
      @required this.notificationStream});

  @override
  State<StatefulWidget> createState() => NotificationBarState();
}

class NotificationBarState extends State<NotificationBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offset;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _offset = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
        .animate(_controller);
    _subscription = widget.notificationStream.listen((data) {
      if (mounted) {
        _showNotification();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  void _showNotification() {
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
