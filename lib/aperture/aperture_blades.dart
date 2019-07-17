/*
 * Created by Alfonso Cejudo, Saturday, July 13th 2019.
 */

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'aperture_blade_painter.dart';

class ApertureBlades extends StatefulWidget {
  final double bladeWidth;
  final AnimationController animationController;
  final Animation curvedAnimation;
  final bool startOpened;

  ApertureBlades(
      {@required this.bladeWidth,
      this.animationController,
      this.curvedAnimation,
      this.startOpened = true});

  @override
  _ApertureBladesState createState() => _ApertureBladesState();
}

class _ApertureBladesState extends State<ApertureBlades>
    with SingleTickerProviderStateMixin {
  static const leafBorderWidth = 2.0;
  static const open1 = 0.78;
  static const open2 = 0.33;

  AnimationController animationController;
  Animation curvedAnimation;

  Animation<Offset> _slide1;
  Animation<Offset> _slide2;
  Animation<Offset> _slide3;
  Animation<Offset> _slide4;
  Animation<Offset> _slide5;
  Animation<Offset> _slide6;

  @override
  void initState() {
    super.initState();

    animationController = widget.animationController != null
        ? widget.animationController
        : AnimationController(
            vsync: this, duration: Duration(milliseconds: 2200));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          animationController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          animationController.forward();
        });
      }
    });

    curvedAnimation = widget.curvedAnimation != null
        ? widget.curvedAnimation
        : CurvedAnimation(
            parent: animationController, curve: Curves.easeInOutBack);

    _slide1 = widget.startOpened
        ? Tween(begin: Offset(open1, 0.0), end: Offset(0.0, 0.0))
            .animate(curvedAnimation)
        : Tween(begin: Offset(0.0, 0.0), end: Offset(open1, 0.0))
            .animate(curvedAnimation);
    _slide2 = widget.startOpened
        ? Tween(begin: Offset(open2, open1), end: Offset(0.0, 0.0))
            .animate(curvedAnimation)
        : Tween(begin: Offset(0.0, 0.0), end: Offset(open2, open1))
            .animate(curvedAnimation);
    _slide3 = widget.startOpened
        ? Tween(begin: Offset(-open2, open1), end: Offset(0.0, 0.0))
            .animate(curvedAnimation)
        : Tween(begin: Offset(0.0, 0.0), end: Offset(-open2, open1))
            .animate(curvedAnimation);
    _slide4 = widget.startOpened
        ? Tween(begin: Offset(-open1, 0.0), end: Offset(0.0, 0.0))
            .animate(curvedAnimation)
        : Tween(begin: Offset(0.0, 0.0), end: Offset(-open1, 0.0))
            .animate(curvedAnimation);
    _slide5 = widget.startOpened
        ? Tween(begin: Offset(-open2, -open1), end: Offset(0.0, 0.0))
            .animate(curvedAnimation)
        : Tween(begin: Offset(0.0, 0.0), end: Offset(-open2, -open1))
            .animate(curvedAnimation);
    _slide6 = widget.startOpened
        ? Tween(begin: Offset(open2, -open1), end: Offset(0.0, 0.0))
            .animate(curvedAnimation)
        : Tween(begin: Offset(0.0, 0.0), end: Offset(open2, -open1))
            .animate(curvedAnimation);

    if (widget.animationController == null) {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (widget.animationController == null) {
      animationController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxWidth = widget.bladeWidth;
    final leafHeight =
        math.sqrt((math.pow(boxWidth, 2) - math.pow((boxWidth / 2), 2)));
    final heightDelta = boxWidth - leafHeight;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final centerX = constraints.maxWidth * 0.5;
        final centerY = constraints.maxHeight * 0.5;

        return Container(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: centerX + (boxWidth / 2),
                top: centerY + heightDelta,
                child: AnimatedBuilder(
                  animation: animationController,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: boxWidth,
                      height: boxWidth,
                      child: CustomPaint(
                        painter: ApertureBladePainter(
                            borderWidth: leafBorderWidth,
                            rotationRadians: math.pi),
                      ),
                    ),
                  ),
                  builder: (context, child) => SlideTransition(
                    position: _slide1,
                    child: child,
                  ),
                ),
              ),
              Positioned(
                left: centerX - leafBorderWidth,
                top: centerY -
                    (boxWidth - leafHeight) -
                    leafHeight +
                    (leafBorderWidth / 2),
                child: AnimatedBuilder(
                  animation: animationController,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: boxWidth,
                      height: boxWidth,
                      child: CustomPaint(
                        painter:
                            ApertureBladePainter(borderWidth: leafBorderWidth),
                      ),
                    ),
                  ),
                  builder: (context, child) =>
                      SlideTransition(position: _slide2, child: child),
                ),
              ),
              Positioned(
                left: centerX + boxWidth - leafBorderWidth,
                top: centerY + heightDelta + leafHeight,
                child: AnimatedBuilder(
                  animation: animationController,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: boxWidth,
                      height: boxWidth,
                      child: CustomPaint(
                        painter: ApertureBladePainter(
                            borderWidth: leafBorderWidth,
                            rotationRadians: math.pi),
                      ),
                    ),
                  ),
                  builder: (context, child) => SlideTransition(
                    position: _slide3,
                    child: child,
                  ),
                ),
              ),
              Positioned(
                left: centerX - (boxWidth * 0.5),
                top: centerY - heightDelta,
                child: AnimatedBuilder(
                  animation: animationController,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: boxWidth,
                      height: boxWidth,
                      child: CustomPaint(
                        painter:
                            ApertureBladePainter(borderWidth: leafBorderWidth),
                      ),
                    ),
                  ),
                  builder: (context, child) => SlideTransition(
                    position: _slide4,
                    child: child,
                  ),
                ),
              ),
              Positioned(
                left: centerX + leafBorderWidth,
                top: centerY + heightDelta + leafHeight,
                child: AnimatedBuilder(
                  animation: animationController,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: boxWidth,
                      height: boxWidth,
                      child: CustomPaint(
                        painter: ApertureBladePainter(
                            borderWidth: leafBorderWidth,
                            rotationRadians: math.pi),
                      ),
                    ),
                  ),
                  builder: (context, child) => SlideTransition(
                    position: _slide5,
                    child: child,
                  ),
                ),
              ),
              Positioned(
                left: centerX - boxWidth + leafBorderWidth,
                top: centerY - heightDelta - leafHeight + (leafBorderWidth / 2),
                child: AnimatedBuilder(
                  animation: animationController,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: boxWidth,
                      height: boxWidth,
                      child: CustomPaint(
                        painter:
                            ApertureBladePainter(borderWidth: leafBorderWidth),
                      ),
                    ),
                  ),
                  builder: (context, child) => SlideTransition(
                    position: _slide6,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
