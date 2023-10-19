import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as deps;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await deps.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    //Get.find<CartController>().cartRepo.getCartHistoryList();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RouteHelper.splashPage,
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
