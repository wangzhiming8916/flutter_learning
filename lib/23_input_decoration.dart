import 'package:flutter/material.dart';

import '00_base_page.dart';

class InputDecorationSamplePage extends BasePage {
  InputDecorationSamplePage({Key key, String title}) : super(key: key, title: title);

  @override
  _InputDecorationSamplePageState createState() => _InputDecorationSamplePageState();
}

const String _emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String _passwordRegex = r'^[\x21-\x7E]{6,16}$';
const String _mobileRegex = r'^1[0-9]{10}$';

class _InputDecorationSamplePageState extends BasePageState<InputDecorationSamplePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorText;

  @override
  Widget buildBody(BuildContext context) {
    final mobileTextField = TextField(
      decoration: InputDecoration(
        hintText: 'Please input your mobile number',
        labelText: 'Mobile',
        errorText: _errorText,
      ),
      onChanged: (text) {
        final validate = RegExp(_mobileRegex).hasMatch(text);
        if (validate && _errorText == null || !validate && _errorText != null) {
          return;
        }

        setState(() => _errorText = validate
            ? null : 'This is not an mobile number');
      },
    );

    final textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    );

    final emailTextField = TextFormField(
      decoration: InputDecoration(
          hintText: 'Please input your email',
          labelText: 'Email',
          border: textFieldBorder,
      ),
      validator: (val) => RegExp(_emailRegex).hasMatch(val)
          ? null : 'This is not an email',
      onSaved: (val) => _email = val,
    );

    final passwordTextField = TextFormField(
      decoration: InputDecoration(
        hintText: 'Please input you password',
        labelText: 'Password',
        border: textFieldBorder,
      ),
      obscureText: true,
      validator: (val) => RegExp(_passwordRegex).hasMatch(val)
          ? null : 'Password format is incorrec',
      onSaved: (val) => _password = val,
    );

    final loginButton = RaisedButton(
      onPressed: _login,
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    final form = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          emailTextField,
          SizedBox(height: 12.0),
          passwordTextField,
          SizedBox(height: 20.0),
          loginButton,
        ],
      ),
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        SizedBox(height: 20.0),
        mobileTextField,
        SizedBox(height: 150.0),
        form,
      ],
    );
  }

  void _login() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }

    form.save();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert'),
        content: Text('Email: $_email, password: $_password'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
