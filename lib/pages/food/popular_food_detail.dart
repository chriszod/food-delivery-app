import 'package:flutter/material.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/app_icon.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_and_text_widget.dart';
import '../../widget/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Dimensions.calc(350),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/food0.png')),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.calc(45),
                left: Dimensions.calcW(20),
                right: Dimensions.calcW(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Dimensions.calc(20)),
            height: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.calc(330)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.calc(20)),
                    topRight: Radius.circular(Dimensions.calc(20))),
                color: Colors.white),
            child: AppColumn(),
          )
        ],
      ),
    );
  }
}
