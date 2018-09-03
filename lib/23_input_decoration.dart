import 'package:flutter/material.dart';

import '00_base_page.dart';

class InputDecorationSamplePage extends BasePage {
  InputDecorationSamplePage({Key key, String title}) : super(key: key, title: title);

  @override
  _InputDecorationSamplePageState createState() => _InputDecorationSamplePageState();
}

const String _emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _InputDecorationSamplePageState extends BasePageState<InputDecorationSamplePage> {
  String _errorText;

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Please input your email',
            errorText: _errorText,
          ),
          onSubmitted: (text) {
            setState(() {
              if (!RegExp(_emailRegex).hasMatch(text)) {
                _errorText = 'This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
        ),
      ),
    );
  }
}
