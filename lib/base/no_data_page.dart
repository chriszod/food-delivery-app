import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/image/empty_cart.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height:  Dimensions.screenHeight*0.22,
          width :  Dimensions.screenWidth*0.22,
        ),
        SizedBox(
          height:  Dimensions.screenHeight*0.03,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize:  Dimensions.screenHeight*0.0175,
            color: Theme.of(context).disabledColor 
          ),
        )
      ],
    );
  }
}
