import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
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
                          Get.to(() => MainFoodPage());
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
          Positioned(
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
                      return ListView.builder(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              
                              height: 100,
                              width: double.maxFinite,
                              margin: EdgeInsets.only(bottom: 10),
                
                              child: Row(
                                children: [
                                  Container(
                                    width: Dimensions.calcW(100),
                                    height: Dimensions.calc(100),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.BASE_URL+AppConstants.UPLOAD+cartController.getItems[index].img!
                                        )),
                                      borderRadius: BorderRadius.circular(Dimensions.calc(20))),
                                  ),
                                  
                                  SizedBox(width: Dimensions.calcW(10),),

                                  Expanded(child: Container(
                                    height: Dimensions.calc(100),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController.getItems[index].name!,
                                          color: Colors.black54,),
                                          SmallText(
                                            text: "Spicey"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            BigText(
                                          text: cartController.getItems[index].price.toString(),
                                          color: Colors.redAccent,),
                                          //////////////////////////////
                                          Container(
                padding: EdgeInsets.all(Dimensions.calc(10)),
                decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimensions.calc(20)))),
                child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //popularProduct.setQuantity(false);
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
                          text: "0",
                          //text: popularProduct.inCartItems.toString(),
                        ),
                        SizedBox(
                          width: Dimensions.calcW(5),
                        ),
                        GestureDetector(
                          onTap: () {
                            //popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                ),
              )

                                          ///////////////////////////////
                                          ],)
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
