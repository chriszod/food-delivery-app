import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:food_delivery/utils/dimensions.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(bottom: Dimensions.calc(15)),
                padding: EdgeInsets.only(
                    left: Dimensions.calc(20), right: Dimensions.calc(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: 'Bangladesh',
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: 'Narshingdi',
                              color: AppColors.mainBlackColor,
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.calc(45),
                        height: Dimensions.calc(45),
                        child: Icon(
                          Icons.search,
                          size: Dimensions.calc(24),
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.calc(15)),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: FoodPageBody())),
          ],
        ),
      ),
    );
  }
}
