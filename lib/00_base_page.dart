import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key key, this.title}) : super(key: key);
  final String title;
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: actions),
      body: buildBody(context),
    );
  }

  List<Widget> get actions => null;
  Widget buildBody(BuildContext context);
}