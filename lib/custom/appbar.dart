import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String subtitle2;
  final Color backgroundColor;
  final Color subtitleBackgroundColor;
  final Color titleTextColor;
  final double toolbarHeight;

  const CustomAppBar({
    Key? key,
    required this.subtitle2,
    required this.title,
    required this.subtitle,
    this.backgroundColor = Colors.indigo,
    this.subtitleBackgroundColor = const Color(0xfff3e5f6),
    this.titleTextColor = Colors.white,
    this.toolbarHeight = 110,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: false, // Remove default back button
      backgroundColor: Colors.transparent, // Transparent AppBar
      elevation: 0, // No shadow
      flexibleSpace: Column(
        children: [
          // Title section
          Container(
            width: double.infinity,
            height: screenHeight * 0.1, // Height for the blue section
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: titleTextColor,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
          ),

          // Subtitle section
          Container(
            width: double.infinity,
            height: screenHeight * 0.05, // Height for the text section
            decoration: BoxDecoration(
              color: subtitleBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  color: Colors.grey,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenWidth * .03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    subtitle2,
                    style: TextStyle(
                      fontSize: screenWidth * .03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
