import 'package:flutter/material.dart';

import '00_base_page.dart';

class GrowTransitionPage extends BasePage {
  GrowTransitionPage({Key key, String title}) : super(key: key, title: title);

  @override
  _GrowTransitionPageState createState() => _GrowTransitionPageState();
}

class _GrowTransitionPageState extends BasePageState<GrowTransitionPage>
    with TickerProviderStateMixin { // ignore: mixin_inherits_from_not_object
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation = Tween(begin: 0.0, end: 300.0).animate(curve);
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
    return Center(
      child: GrowTransition(
        animation: _animation,
        child: LogoWidget(),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({Key key, this.animation, this.child}) : super(key: key);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, build) => Container(
        width: animation.value,
        height: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}

class LogoWidget extends StatelessWidget {
  LogoWidget({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: FlutterLogo(),
    );
  }
}

