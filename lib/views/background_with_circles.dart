import 'package:flutter/material.dart';

class BackgroundWithCircles extends StatelessWidget {
  final Color backgroundColor;
  final Color overlayColor;
  final Widget child;

  const BackgroundWithCircles({
    super.key,
    required this.backgroundColor,
    required this.overlayColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double baseCircleSize = 100; // Base size of each circle
    final int circlesAmount = screenWidth ~/ baseCircleSize;
    final double circleWidth =
        screenWidth / circlesAmount; // New width for each circle

    return Column(
      children: [
        Container(
          color: backgroundColor,
          width: double.infinity,
          child: child,
        ),
        Container(
          color: overlayColor,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              circlesAmount,
              (index) => HalfCircleWidget(
                width: circleWidth, // Use the new width
                color: backgroundColor,
                overlayColor: overlayColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HalfCircleWidget extends StatelessWidget {
  final double width;
  final Color color;
  final Color overlayColor;

  const HalfCircleWidget({
    super.key,
    required this.width, // Add width parameter
    required this.color,
    required this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Use the passed width
      height: width / 2, // Keep the height proportional to the width
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: double.infinity,
          color: color,
        ),
      ),
    );
  }
}
