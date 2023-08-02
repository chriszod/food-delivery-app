import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:food_delivery/widget/icon_and_text_widget.dart';
import 'package:food_delivery/widget/small_text.dart';

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
        Container(
          height: Dimensions.calc(320),
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          height: Dimensions.calc(30),
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.calcW(30)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: 'Popular'),
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
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  left: Dimensions.calcW(20), right: Dimensions.calcW(20)),
              height: Dimensions.calc(140),
              child: Row(children: [
                Container(
                  height: Dimensions.calc(120),
                  width: Dimensions.calc(120),
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(Dimensions.calc(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/food0.png'))),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(Dimensions.calc(20)),
                            topRight: Radius.circular(Dimensions.calc(20)))),
                    height: Dimensions.calc(100),
                    padding: EdgeInsets.all(Dimensions.calc(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                              text:
                                  'Nutritious fruit meal in town and beyond the sky'),
                          SmallText(text: 'With chinese charactistics'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            );
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
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
          Container(
            height: Dimensions.calc(220),
            margin: EdgeInsets.only(
                left: Dimensions.calc(10), right: Dimensions.calc(10)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.calc(30)),
                color: index.isEven ? Colors.blue : Colors.purple,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/food0.png"))),
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
                child: AppColumn(),
              ))
        ],
      ),
    );
  }
}
