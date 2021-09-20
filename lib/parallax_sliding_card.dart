import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotel_booking_concept/common/icons.dart';
import 'package:hotel_booking_concept/common/widget/blur_icon.dart';
import 'package:hotel_booking_concept/parallax_page_view.dart';

class SlidingCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageAssetName;
  final double offset;
  final int position;
  final int? height;
  final double scaleCoefficient;
  final double viewportFraction;
  final void Function(int) onCardTap;

  const SlidingCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.imageAssetName,
    required this.offset,
    required this.position,
    required this.height,
    required this.onCardTap,
    required this.viewportFraction,
    this.scaleCoefficient = 0.0,
  }) : super(key: key);

  static double? kMaxRadius;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    kMaxRadius = MediaQuery.of(context).size.height;
    double gaussCurve = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    Offset cardOffsetExpression = Offset(-8 * gaussCurve * offset.sign, 0);

    final scale = max(0.9, offset.abs() + scaleCoefficient);
    double cardHeightCalc =
        scaleCoefficient == 0 ? height!.toDouble() : height! / scale;
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: cardHeightCalc,
        child: Transform.translate(
          offset: cardOffsetExpression,
          child: GestureDetector(
            onTap: () => onCardTap(position),
            child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Stack(
                children: <Widget>[
                  _buildShadow(),
                  _buildCoverImage(position, imageAssetName, offset),
                  _buildGradientShape(),
                  Positioned(
                    child: Hero(
                      tag: "${title}heart",
                      child: BlurIcon(
                        width: 28,
                        height: 28,
                        icon: Icon(
                          HotelBookingConcept.ic_heart_empty,
                          color: Colors.white,
                          size: 15.2,
                        ),
                      ),
                    ),
                    top: 16,
                    right: 16,
                  ),
                  Positioned(
                    child: Hero(
                        tag: "${title}chevron",
                        child: BlurIcon(
                          width: 0,
                          height: 0,
                          icon: Icon(
                            HotelBookingConcept.ic_chevron_left,
                            color: Colors.white,
                            size: 0,
                          ),
                        )),
                    top: 16,
                    left: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 4,
                        ),
                        Text(subTitle,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShadow() {
    return Container(
      margin: EdgeInsets.only(left: 14, right: 14, top: 16, bottom: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 4.0),
            color: Color(0x591a86ff),
            blurRadius: 18.0,
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage(int? position, String? imageAssetName, double offset) {
    double imageBoundsCalc = viewportFraction / 0.6 * 1000;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Hero(
        createRectTween: ParallaxPageView.createRectTween,
        tag: "$title",
        child: Image.asset(
          '$imageAssetName',
          fit: BoxFit.cover,
          height: imageBoundsCalc,
          width: imageBoundsCalc * 20,
          alignment: Alignment(offset / 2, 0),
        ),
      ),
    );
  }

  Widget _buildGradientShape() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.7, 1.0],
          colors: [
            Color(0x00000000),
            Color(0x00000000),
            Color(0xff000000),
          ],
        ),
      ),
    );
  }
}

abstract class ISlidingCard {
  String cardTitle();

  String cardSubTitle();

  String cardImageAsset();
}
