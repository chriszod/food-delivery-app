import 'package:flutter/material.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/expandable_text_widget.dart';

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
      backgroundColor: Colors.white,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppColumn(text: 'Biriani'),
                SizedBox(
                  height: Dimensions.calc(20),
                ),
                BigText(text: 'Introduce'),
                SizedBox(
                  height: Dimensions.calc(20),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text:
                              'sjkxbsijkxbskjx jdhsij jkxbsijkxbskjx jdhsijkcbnsijkchnsijcksnc sikcjmsnc sikc scsciksm css csic sc sicjs cisk csick scissbxsjkbxsjkxbsijkxbskjx jdhsijkcbnsijkchnsijcksnc sikcjmsnc sikc scsciksm css csic sc sicjs cisk csick scissbxsjkbxsjkxbsijkxbskjx jdhsijkcbnsijkchnsijcksnc sikcjmsnc sikc scsciksm css csic sc sicjs cisk csick scissbxsjkbxsvvvvvjkxbsijkxbskjx jdhsijkcbnsijkchnsijcksnc sikcjmsnc sikc scsciksm css csic sc sicjs cisk csick scissbxsjkbxskcbnsijkchnsijcksnc sikcjmsnc sikc scsciksm css csic sc sicjs cisk csick scissbxsjkbxs')),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.calc(120),
        padding: EdgeInsets.all(Dimensions.calc(20)),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.calc(40)),
                topRight: Radius.circular(Dimensions.calc(40)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.calc(20)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.calc(20)))),
              child: Row(
                children: [
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(
                    width: Dimensions.calcW(5),
                  ),
                  BigText(
                    text: '0',
                  ),
                  SizedBox(
                    width: Dimensions.calcW(5),
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.calc(20)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.calc(20)))),
              child: BigText(text: '\$10 | Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}
