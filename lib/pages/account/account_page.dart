import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/account_widget.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          color: Colors.white,
          size: Dimensions.calc(24),
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (!userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.calc(20)),
                    child: Column(
                      children: [
                        //profile icon
                        AppIcon(
                          icon: Icons.person,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimensions.calc(75),
                          size: Dimensions.calc(150).toInt(),
                        ),

                        SizedBox(
                          height: Dimensions.calc(30),
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //name
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      iconColor: Colors.white,
                                      backgroundColor: AppColors.mainColor,
                                      iconSize: Dimensions.calc(25),
                                      size: Dimensions.calc(50).toInt(),
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.name)),

                                SizedBox(
                                  height: Dimensions.calc(30),
                                ),

                                //phone
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      iconColor: Colors.white,
                                      backgroundColor: AppColors.yellowColor,
                                      iconSize: Dimensions.calc(25),
                                      size: Dimensions.calc(50).toInt(),
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.phone)),

                                SizedBox(
                                  height: Dimensions.calc(30),
                                ),

                                //email
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      iconColor: Colors.white,
                                      backgroundColor: AppColors.yellowColor,
                                      iconSize: Dimensions.calc(25),
                                      size: Dimensions.calc(50).toInt(),
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.email)),

                                SizedBox(
                                  height: Dimensions.calc(30),
                                ),

                                //address
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.location_on,
                                      iconColor: Colors.white,
                                      backgroundColor: AppColors.yellowColor,
                                      iconSize: Dimensions.calc(25),
                                      size: Dimensions.calc(50).toInt(),
                                    ),
                                    bigText:
                                        BigText(text: "fill in your address")),

                                SizedBox(
                                  height: Dimensions.calc(30),
                                ),

                                //message
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message,
                                      iconColor: Colors.white,
                                      backgroundColor: Colors.redAccent,
                                      iconSize: Dimensions.calc(25),
                                      size: Dimensions.calc(50).toInt(),
                                    ),
                                    bigText: BigText(text: "Messages")),

                                SizedBox(
                                  height: Dimensions.calc(30),
                                ),

                                //message
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.offNamed(RouteHelper.signIn);
                                    }
                                  },
                                  child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        iconColor: Colors.white,
                                        backgroundColor: Colors.redAccent,
                                        iconSize: Dimensions.calc(25),
                                        size: Dimensions.calc(50).toInt(),
                                      ),
                                      bigText: BigText(text: "Logout")),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : CustomLoader())
            : Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.calc(160),
                      margin: EdgeInsets.only(
                          left: Dimensions.calcW(20),
                          right: Dimensions.calcW(20)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.calc(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/image/signintocontinue.png"))),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.signIn);
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.calc(100),
                        margin: EdgeInsets.only(
                            left: Dimensions.calcW(20),
                            right: Dimensions.calcW(20)),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.calc(20)),
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign in",
                            color: Colors.white,
                            size: Dimensions.calc(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              );
      }),
    );
  }
}
