import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: Dimensions.calc(350),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD +
                      product.img)),
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
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.initial);
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
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
                Container(
                    height: Dimensions.calc(100),
                    child: AppColumn(
                      text: product.name,
                    )),
                SizedBox(
                  height: Dimensions.calc(20),
                ),
                BigText(text: 'Introduce'),
                SizedBox(
                  height: Dimensions.calc(20),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ReadMoreText(
                      product.description,
                      trimLines: 10,
                      style: TextStyle(
                          color: AppColors.paraColor,
                          fontSize: Dimensions.calc(12),
                          fontWeight: FontWeight.w400),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: TextStyle(
                          fontSize: Dimensions.calc(14),
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor),
                      lessStyle: TextStyle(
                          fontSize: Dimensions.calc(14),
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
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
                  color: AppColors.mainColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.calc(20)))),
              child: BigText(
                  color: Colors.white,
                  text: '\$${product.price} | Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}
