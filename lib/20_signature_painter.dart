import 'package:flutter/material.dart';

import '00_base_page.dart';

class SignaturePage extends BasePage {
  SignaturePage({Key key, String title}) : super(key: key, title: title);
  
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends BasePageState<SignaturePage> {
  static GlobalKey painterKey = GlobalKey();
  List<Offset> _points = <Offset>[];
  
  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox referenceBox = painterKey.currentContext.findRenderObject();
          Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (details) => _points.add(null),
      child: SizedBox.expand(
        child: CustomPaint(
          key: painterKey,
          painter: SignaturePainter(points: _points),
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter({this.points, this.path});

  final List<Offset> points;
  final Path path;

  bool shouldRepaint(SignaturePainter other) => true;//other.points != points;

  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }
}