import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder;
    itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        var inputDate = DateTime.parse(parseDate.toString());
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(children: [
        Container(
          color: AppColors.mainColor,
          height: Dimensions.calc(100),
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.calc(45)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "Cart History",
                color: Colors.white,
              ),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
                backgroundColor: AppColors.yellowColor,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(
          builder: (_cartController) {
            return _cartController.getCartHistoryList().length<=0?
            SizedBox(
              height: Dimensions.screenHeight/1.5,
              child: NoDataPage(text: "You didnt buy anything so far", imgPath: "assets/image/empty_box.png",)):
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.calc(20),
                  left: Dimensions.calcW(20),
                  right: Dimensions.calcW(20),
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.calc(120),
                          margin: EdgeInsets.only(bottom: Dimensions.calc(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(
                                height: Dimensions.calc(10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children:
                                          List.generate(itemsPerOrder[i], (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                height: Dimensions.calc(80),
                                                width: Dimensions.calc(80),
                                                margin: EdgeInsets.only(
                                                    right: Dimensions.calc(5)),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions.calc(8)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants.BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                              )
                                            : Container();
                                      })),
                                  Container(
                                    height: Dimensions.calc(80),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: AppColors.titleColor,
                                        ),
                                        BigText(
                                          text: itemsPerOrder[i].toString() +
                                             (itemsPerOrder[i]>1?" items":" item"),
                                          color: AppColors.titleColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for (int j = 0;
                                                j < getCartHistoryList.length;
                                                j++) {
                                              if (getCartHistoryList[j].time ==
                                                  orderTime[i]) {
                                                moreOrder.putIfAbsent(
                                                    getCartHistoryList[j].id!,
                                                    () => CartModel.fromJson(
                                                        jsonDecode(jsonEncode(
                                                            getCartHistoryList[
                                                                j]))));
                                              }
                                            }
                                            Get.find<CartController>().setItems =
                                                moreOrder;
                                            Get.find<CartController>()
                                                .addToCartList();
                                            Get.toNamed(RouteHelper.cartPage);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.calcW(10),
                                                vertical: Dimensions.calc(5)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  Dimensions.calc(5)),
                                              border: Border.all(
                                                  width: Dimensions.calcW(1),
                                                  color: AppColors.mainColor),
                                            ),
                                            child: SmallText(
                                              text: "one more",
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          }
        )
      ]),
    );
  }
}
