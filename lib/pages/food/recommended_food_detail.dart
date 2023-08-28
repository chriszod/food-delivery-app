import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.calc(80),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.initial);
                    },
                    child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.calc(20)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.calc(20)),
                        topRight: Radius.circular(Dimensions.calc(20)))),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: Dimensions.calc(5), bottom: Dimensions.calc(10)),
                child: Center(
                    child: BigText(
                  text: product.name,
                  size: Dimensions.calc(26),
                )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.calc(300),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD + product.img,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(Dimensions.calc(20)),
              child: ReadMoreText(
                product.description,
                trimLines: 10,
                style: TextStyle(
                    height: 1.5,
                    color: AppColors.paraColor,
                    fontSize: Dimensions.calc(16),
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
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                iconSize: Dimensions.calc(24),
                icon: Icons.remove,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
              SizedBox(
                width: Dimensions.calcW(30),
              ),
              BigText(
                text: '\$${product.price}  X  0',
                size: Dimensions.calc(26),
              ),
              SizedBox(
                width: Dimensions.calcW(30),
              ),
              AppIcon(
                iconSize: Dimensions.calc(24),
                icon: Icons.add,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
            ],
          ),
          Container(
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
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.calc(20)))),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.calc(20)),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.calc(20)))),
                  child: BigText(
                    text: '\$${product.price} | Add to cart',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
