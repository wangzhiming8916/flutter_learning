import 'package:flutter/material.dart';

import '00_base_page.dart';

class SimpleAnimationPage extends BasePage {
  SimpleAnimationPage({Key key, String title}) : super(key: key, title: title);

  @override
  _SimpleAnimationPageState createState() => _SimpleAnimationPageState();
}

class _SimpleAnimationPageState extends BasePageState<SimpleAnimationPage>
    with TickerProviderStateMixin<SimpleAnimationPage> { // ignore: mixin_inherits_from_not_object
  AnimationController _controller;
  CurvedAnimation _curve;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,);
    _controller.animateTo(1.0, duration: const Duration(milliseconds: 1000));
//    _controller.value = 1.0;
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.isCompleted ? _controller.reverse() : _controller.forward(),
        child: Icon(Icons.brush),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _curve,
        child: RotationTransition(
          turns: _curve,
          child: ScaleTransition(
            scale: _curve,
            child: FlutterLogo(size: 100.0),
          ),
        ),
      ),
    );
  }
}