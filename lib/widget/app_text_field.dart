import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData iconData;
  bool isObscure;

   AppTextField(
      {Key? key,
      required this.hintText,
      required this.iconData,
      required this.textEditingController,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.calc(20), 
        right: Dimensions.calc(20),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.calc(15)),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        obscureText: isObscure?true:false,
        controller: textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.calc(15),
            ),
          ),
          hintText: hintText,
          prefixIcon: Icon(
            iconData,
            color: AppColors.yellowColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.calc(15),
              ),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.calc(15),
              ),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
