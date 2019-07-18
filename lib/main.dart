import 'package:flutter/material.dart';
import 'package:trigger_animation_example/with_stream.dart';

import 'with_globalkey.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Trigger animation example"),
          ),
          body: Center(
            child: ControlsWidget(),
          ),
        ));
  }
}

class ControlsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text("Example with GlobalKey"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DemoWithGlobalKey(),
            ));
          },
        ),
        RaisedButton(
          child: Text("Example with Stream"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DemoWithStream(),
            ));
          },
        ),
      ],
    );
  }
}
