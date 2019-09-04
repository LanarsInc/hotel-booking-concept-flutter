import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotel_booking_concept/common/theme.dart';
import 'package:hotel_booking_concept/sliding_bottom_sheet_content.dart';

class SlidingBottomSheet extends StatefulWidget {
  final AnimationController controller;
  final double cornerRadius;

  SlidingBottomSheet({this.controller, this.cornerRadius});

  @override
  _SlidingBottomSheetState createState() => _SlidingBottomSheetState(
      bottomSheetController: controller, cornerRadius: cornerRadius);
}

class _SlidingBottomSheetState extends State<SlidingBottomSheet>
    with SingleTickerProviderStateMixin {
  final AnimationController bottomSheetController;
  final double cornerRadius;

  _SlidingBottomSheetState({this.bottomSheetController, this.cornerRadius});

  double get halfScreen => MediaQuery.of(context).size.height / 2;

  double get fullScreen => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((v) {
      _animateToInitial();
    });
  }

  @override
  void dispose() {
    bottomSheetController.dispose();
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, bottomSheetController.value);

  void _animateToInitial() {
    bottomSheetController.animateTo(0.5, duration: Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = HotelConceptThemeProvider.get();
    return AnimatedBuilder(
      animation: bottomSheetController,
      builder: (context, child) {
        final double topMargin = 20;
        double topMarginAnimatedValue = (1 - bottomSheetController.value) * topMargin * 2;
        final radiusAnimatedValue = Radius.circular(
            (1 - bottomSheetController.value) * cornerRadius * 2);
        final double bottomSheetDragIndicatorWidth = 76;
        double bottomSheetDragIndicatorWidthUpdatedValue =
            (1 - bottomSheetController.value) *
                (bottomSheetDragIndicatorWidth * 2);
        return Positioned(
          height: bottomSheetController.value * fullScreen,
          bottom: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: WillPopScope(
              onWillPop: () async {
                if (bottomSheetController.value > 0.5) {
                  await bottomSheetController.animateTo(0.5,
                      duration: Duration(milliseconds: 150));
                  return false;
                } else {
                  await bottomSheetController.animateTo(0,
                      duration: Duration(milliseconds: 150));
                  return true;
                }
              },
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: radiusAnimatedValue)),
                  child: Stack(children: <Widget>[
                    AnimatedPositioned(
                      duration:  Duration(milliseconds: 200),
                      top: topMarginAnimatedValue,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: themeData.textTheme.display4.color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          height: 4,
                          width: bottomSheetDragIndicatorWidthUpdatedValue,
                        ),
                      ),
                    ),
                    BottomSheetContent(controller: bottomSheetController)
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    double dragSpeedToScreenSizeRatio = details.primaryDelta / fullScreen;
    double bottomSheetUpdatedValue =
        bottomSheetController.value - dragSpeedToScreenSizeRatio;

    if (bottomSheetUpdatedValue >= 0.5) {
      bottomSheetController.value = bottomSheetUpdatedValue;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (bottomSheetController.isAnimating ||
        bottomSheetController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / fullScreen;
    if (flingVelocity < 0.0) {
      bottomSheetController.fling(velocity: math.max(1.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      bottomSheetController.animateTo(0.5,
          duration: Duration(milliseconds: 250));
    } else {
      _animateToInitial();
    }
  }
}
