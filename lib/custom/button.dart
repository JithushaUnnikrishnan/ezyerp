import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.color,
      required this.text,
      required this.TextColor,required this.onPressed});
  final Color color;
  final Color TextColor;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: 170,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: TextColor,fontWeight: FontWeight.w500,fontSize: 19),
          ),
        ),
       decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff8b56fe), Color(0xff5577f8),],begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
