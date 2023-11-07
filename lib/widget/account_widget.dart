import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, 
  required this.appIcon, 
  required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0,2),
            blurRadius: 1
          )
        ]
      ),
    
      padding: EdgeInsets.only(
          left: Dimensions.calcW(20),
          top: Dimensions.calc(10),
          bottom: Dimensions.calc(10)),
          child: Row(
            children: [
              appIcon,
              SizedBox(width: Dimensions.calcW(20),),
              bigText
            ],
          ),
    );
  }
}
