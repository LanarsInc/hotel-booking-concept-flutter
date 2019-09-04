import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotel_booking_concept/common/theme.dart';

class BlurIcon extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets padding;
  final Icon icon;

  BlurIcon({this.width = 32, this.height = 32, this.icon, this.padding});

  @override
  Widget build(BuildContext context) {
    final themeData = HotelConceptThemeProvider.get();
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Padding(
          padding: padding == null ? EdgeInsets.all(0) : padding,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeData.hoverColor,
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
