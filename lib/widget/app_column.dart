import 'package:flutter/material.dart';
import 'package:food_delivery/widget/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: text,
            size: Dimensions.calc(26),
          ),
          SizedBox(
            height: Dimensions.calc(10),
          ),
          Row(
            children: [
              Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          size: 15,
                          color: AppColors.mainColor,
                        )),
              ),
              SizedBox(
                width: Dimensions.calcW(10),
              ),
              SmallText(text: '4.5'),
              SizedBox(
                width: Dimensions.calcW(20),
              ),
              SmallText(text: '1247'),
              SizedBox(
                width: Dimensions.calcW(10),
              ),
              SmallText(text: 'comments'),
            ],
          ),
          SizedBox(
            height: Dimensions.calc(20),
          ),
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
        ],
      ),
    );
  }
}
