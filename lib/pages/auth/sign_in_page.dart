import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_text_field.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom-message.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar("Type in your email", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackbar("Type in your password", title: "Password");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.length < 6) {
        showCustomSnackbar("Password cannot be less than six characters",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.initial);
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    Container(
                      height: Dimensions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: Dimensions.calc(80),
                          backgroundImage:
                              AssetImage("assets/image/logo part 1.png"),
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: Dimensions.calc(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                                fontSize: Dimensions.calc(70),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sign into your account",
                            style: TextStyle(fontSize: Dimensions.calc(20)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.calc(40),
                    ),
                    AppTextField(
                        hintText: "Email",
                        iconData: Icons.email,
                        textEditingController: emailController),
                    SizedBox(
                      height: Dimensions.calc(20),
                    ),
                    AppTextField(
                        hintText: "Password",
                        iconData: Icons.password_sharp,
                        isObscure: true,
                        textEditingController: passwordController),
                    SizedBox(
                      height: Dimensions.calc(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Sign into your account",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.calc(20),
                                ))),
                        SizedBox(
                          width: Dimensions.calcW(20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.calc(40),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.calc(30)),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              text: "Sign in",
                              size: Dimensions.calc(30),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have an account? ",
                          style: TextStyle(
                            fontSize: Dimensions.calc(20),
                            color: Colors.grey[500],
                          ),
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fade),
                                text: "Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.calc(20),
                                ))),
                      ],
                    ),
                  ],
                ),
              )
            : CustomLoader();
      }),
    );
  }
}
