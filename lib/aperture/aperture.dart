/*
 * Created by Alfonso Cejudo, Saturday, July 13th 2019.
 */

import 'package:flutter/material.dart';
import 'aperture_blades.dart';

class Aperture extends StatelessWidget {
  /// The optional child is visible when the Aperture is not fully closed, and
  /// is wrapped inside a clipped container so that its contents only appear
  /// within the Aperture bounds.
  final Widget child;

  /// Set the starting position of the Aperture to be opened (default) or
  /// closed.
  final bool startOpened;

  final AnimationController animationController;
  final Animation curvedAnimation;

  Aperture({
      this.child,
      this.animationController,
      this.curvedAnimation,
      this.startOpened = true});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final radius = constraints.maxWidth * 0.5;
      final bladeWidth = constraints.maxWidth * 0.75;

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (child != null)
            ClipOval(
              clipper: RadiusClipper(radius: radius),
              child: Container(
                alignment: Alignment.center,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: child,
              ),
            ),
          ClipOval(
            clipper: RadiusClipper(radius: radius),
            clipBehavior: Clip.antiAlias,
            child: ApertureBlades(
              bladeWidth: bladeWidth,
              animationController: animationController,
              curvedAnimation: curvedAnimation,
              startOpened: startOpened,
            ),
          ),
        ],
      );
    },);
  }
}

class RadiusClipper extends CustomClipper<Rect> {
  double _radius;

  RadiusClipper({@required radius}) : _radius = radius;

  @override
  getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.5), radius: _radius);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
