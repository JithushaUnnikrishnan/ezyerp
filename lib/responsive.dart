import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const Responsive({
    super.key,
    required this.largeScreen,
    required this.mediumScreen,
    required this.smallScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  @override

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return largeScreen;  // Large screen layout
        } else if (constraints.maxWidth <= 1200 && constraints.maxWidth >= 600) {
          return mediumScreen??largeScreen; // Medium screen layout
        } else {
          return smallScreen??largeScreen;  // Small screen layout
        }
      },
    );
  }
}
