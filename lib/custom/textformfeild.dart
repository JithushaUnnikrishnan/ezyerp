import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield(
      {super.key, required this.hintText, required this.PrefixIcon,required this.controller});
  final String hintText;
  final IconData PrefixIcon;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: controller,
      validator: (value){if(value!.isEmpty){return "empty $hintText";}},
      decoration: InputDecoration( contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), 
          border: OutlineInputBorder(
       
         
                
      borderRadius: BorderRadius.circular(10)),
          hintText: hintText,hintStyle: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w400,fontSize: 14),
          prefixIcon: Icon(PrefixIcon,color: Colors.black,)),
    );
  }
}
