import 'dart:math' as math;

import 'package:flutter/material.dart';

import '00_base_page.dart';

class AnimatedLogoPage extends BasePage {
  AnimatedLogoPage({Key key, String title}) : super(key: key, title: title);

  @override
  _AnimatedLogoPageState createState() => _AnimatedLogoPageState();
}

class _AnimatedLogoPageState extends BasePageState<AnimatedLogoPage>
    with TickerProviderStateMixin<AnimatedLogoPage> { // ignore: mixin_inherits_from_not_object
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 300.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return AnimatedLogo(animation: _animation);
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final progress = animation.value / 300;
    final colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.red];

    return Center(
      child: ClipOval(
        child: SizedBox(
          width: 300.0,
          height: 300.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(progress * math.pi * 2),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: SweepGradient(colors: colors),
                  ),
                ),
              ),
              Opacity(
                opacity: progress,
                child: Container(
                  padding: const EdgeInsets.all(50.0),
                  width: animation.value,
                  height: animation.value,
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}