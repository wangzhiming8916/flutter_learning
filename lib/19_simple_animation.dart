import 'dart:math' as math;

import 'package:flutter/material.dart';

import '00_base_page.dart';

class SimpleAnimationPage extends BasePage {
  SimpleAnimationPage({Key key, String title}) : super(key: key, title: title);

  @override
  _SimpleAnimationPageState createState() => _SimpleAnimationPageState();
}

class _SimpleAnimationPageState extends BasePageState<SimpleAnimationPage>
    with TickerProviderStateMixin<SimpleAnimationPage> { // ignore: mixin_inherits_from_not_object
  AnimationController _curveController;
  CurvedAnimation _curve;

  AnimationController _rotationController;
  Animation<double> _rotationCurve;
  Animation<double> _rotation;

  @override
  void initState() {
    _curveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _curveController, curve: Curves.easeInOut);
    _curveController.value = 1.0;

    _rotationController = AnimationController(vsync: this);
    _rotationCurve = CurvedAnimation(parent: _rotationController, curve: Curves.linear);
    _rotation = Tween(begin: 0.0, end: 10.0).animate(_rotationCurve);

    _rotationController.addListener(() {
      setState(() {});
      print('${_rotationController.value}, ${_rotationCurve.value}, ${_rotation.value}');
    });
    _rotationController.animateTo(1.0, duration: const Duration(seconds: 10));

    super.initState();
  }

  @override
  void dispose() {
    _curveController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(title: Text(widget.title)),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _curveController.isCompleted
            ? _curveController.reverse() : _curveController.forward(),
        child: Icon(Icons.brush),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(_rotation.value * math.pi * 2.0),
            child: FlutterLogo(size: 100.0),
          ),
          SizedBox(height: 50.0),
          RotationTransition(
            turns: _rotation,
            child: FlutterLogo(size: 100.0),
          ),
          SizedBox(height: 50.0),
          FadeTransition(
            opacity: _curve,
            child: RotationTransition(
              turns: _curve,
              child: ScaleTransition(
                scale: _curve,
                child: FlutterLogo(size: 100.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}