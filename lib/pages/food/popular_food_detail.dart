import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
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
  final int pageId;
  final String page;
  PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
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
                      if (page == "cartpage") {
                        Get.toNamed(RouteHelper.cartPage);
                      } else {
                        Get.toNamed(RouteHelper.initial);
                      }
                    }, child: const AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(RouteHelper.cartPage);
                      }
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: Dimensions.calc(20).toInt(),
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: Dimensions.calc(12),
                                  color: Colors.white,
                                ))
                            : Container(),
                        
                      ],
                    ),
                  );
                }),
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
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
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
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.calcW(5),
                    ),
                    BigText(
                      text: popularProduct.inCartItems.toString(),
                    ),
                    SizedBox(
                      width: Dimensions.calcW(5),
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.calc(20)),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.calc(20)))),
                  child: BigText(
                      color: Colors.white,
                      text: '\$${product.price} | Add to cart'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
