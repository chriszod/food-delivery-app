import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:get/get.dart';

import '../home/main_food_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.calc(60),
              left: Dimensions.calcW(20),
              right: Dimensions.calcW(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.calc(24).toInt(),
                  ),
                  SizedBox(
                    width: Dimensions.calcW(100),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.initial);
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      size: Dimensions.calc(24).toInt(),
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.calc(24).toInt(),
                  )
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length <= 0
                ? NoDataPage(text: "Your cart is empty!")
                : Positioned(
                    top: Dimensions.calc(100),
                    left: Dimensions.calcW(20),
                    right: Dimensions.calcW(20),
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.calc(15)),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                            builder: (cartController) {
                          var _cartList = cartController.getItems;
                          return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 100,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product);

                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, 'cartpage'));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    _cartList[index].product);

                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                  "History Product,",
                                                  " Product review is " +
                                                      "not available for history products.",
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  colorText: Colors.white);
                                            } else {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                      recommendedIndex,
                                                      'cartpage'));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.calcW(100),
                                          height: Dimensions.calc(100),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants.UPLOAD +
                                                          cartController
                                                              .getItems[index]
                                                              .img!)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.calc(20))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.calcW(10),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: Dimensions.calc(100),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: cartController
                                                  .getItems[index].name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(text: "Spicey"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].price
                                                      .toString(),
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.calc(10)),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              Dimensions.calc(
                                                                  20)))),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.calcW(5),
                                                      ),
                                                      BigText(
                                                        text: _cartList[index]
                                                            .quantity
                                                            .toString(),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.calcW(5),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              });
                        }),
                      ),
                    ));
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.calc(120),
          padding: EdgeInsets.all(Dimensions.calc(20)),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.calc(40)),
                  topRight: Radius.circular(Dimensions.calc(40)))),
          child: cartController.getItems.length <= 0
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.calc(20)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.calc(20)))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Dimensions.calcW(5),
                          ),
                          BigText(
                            text: "\$ " + cartController.totalAmount.toString(),
                          ),
                          SizedBox(
                            width: Dimensions.calcW(5),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          cartController.addToHistory();
                        } else {
                          Get.toNamed(RouteHelper.signIn);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.calc(20)),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.calc(20)))),
                        child: BigText(color: Colors.white, text: 'Check Out'),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
