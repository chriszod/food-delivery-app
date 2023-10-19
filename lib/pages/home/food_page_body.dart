import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/icon_and_text_widget.dart';
import 'package:food_delivery/widget/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.calc(220);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.calc(320),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position,
                          popularProducts.popularProductList[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue.toInt(),
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.calc(30),
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.calcW(30)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: 'Recommended'),
            SizedBox(
              width: Dimensions.calcW(10),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: BigText(
                text: '.',
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: Dimensions.calcW(10),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing ')),
          ]),
        ),
        SizedBox(
          height: Dimensions.calc(30),
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recommendedProducts.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index, 'home'));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.calcW(20),
                            right: Dimensions.calcW(20)),
                        height: Dimensions.calc(140),
                        child: Row(children: [
                          Container(
                            height: Dimensions.calc(120),
                            width: Dimensions.calc(120),
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.calc(20)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD +
                                        recommendedProducts
                                            .recommendedProductList[index]
                                            .img!))),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(Dimensions.calc(20)),
                                      topRight: Radius.circular(
                                          Dimensions.calc(20)))),
                              height: Dimensions.calc(100),
                              padding: EdgeInsets.all(Dimensions.calc(10)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text: recommendedProducts
                                            .recommendedProductList[index]
                                            .name!),
                                    SmallText(
                                        text: recommendedProducts
                                            .recommendedProductList[index]
                                            .description!),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(
                                            icon: Icons.circle_sharp,
                                            text: 'Normal',
                                            iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(
                                            icon: Icons.location_on,
                                            text: '1.7km',
                                            iconColor: AppColors.mainColor),
                                        IconAndTextWidget(
                                            icon: Icons.access_time_rounded,
                                            text: '32mins',
                                            iconColor: AppColors.iconColor2)
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - currentScale) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              height: Dimensions.calc(220),
              margin: EdgeInsets.only(
                  left: Dimensions.calc(10), right: Dimensions.calc(10)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.calc(30)),
                  color: index.isEven ? Colors.blue : Colors.purple,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD +
                          popularProduct.img!))),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.calc(120),
                margin: EdgeInsets.only(
                    left: Dimensions.calc(30),
                    right: Dimensions.calc(30),
                    bottom: Dimensions.calc(30)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.calc(20)),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0))
                    ]),
                padding: EdgeInsets.only(
                    top: Dimensions.calc(15),
                    left: Dimensions.calc(15),
                    right: Dimensions.calc(15)),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ))
        ],
      ),
    );
  }
}
