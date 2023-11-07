import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom-message.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/sign_up_body.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widget/app_text_field.dart';
import 'package:food_delivery/widget/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = ["t.png", "f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackbar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
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
        SignUpBody signUpBody = SignUpBody(
            email: email, name: name, password: password, phone: phone);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success registration");
            Get.offNamed(RouteHelper.initial);
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
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
                    AppTextField(
                        hintText: "Name",
                        iconData: Icons.person,
                        textEditingController: nameController),
                    SizedBox(
                      height: Dimensions.calc(20),
                    ),
                    AppTextField(
                        hintText: "Phone",
                        iconData: Icons.phone,
                        textEditingController: phoneController),
                    SizedBox(
                      height: Dimensions.calc(40),
                    ),
                    GestureDetector(
                      onTap: () {
                        _registration(_authController);
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
                            text: "Sign up",
                            size: Dimensions.calc(30),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.calc(10),
                    ),
                    RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(RouteHelper.signIn),
                            text: "Have an account already?",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.calc(20),
                            ))),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    RichText(
                        text: TextSpan(
                            text: "Sign up use one of the following methods",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.calc(16),
                            ))),
                    Wrap(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: Dimensions.calc(30),
                                  backgroundImage: AssetImage(
                                    "assets/image/" + signUpImages[index],
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              )
            : CustomLoader();
      }),
    );
  }
}
